import 'dart:io';

import 'package:booknow_mobile/core/extensions/color_extension.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/logger/app_logger.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/shop_setup_chrome.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The shop's photo: an empty dashed panel until there is one, the photo
/// itself afterwards.
///
/// The picked file is handed back rather than kept here, because the owner can
/// leave this step and come back and the choice has to survive that. Nothing
/// is uploaded yet — there is no endpoint — so a photo lives only as long as
/// the wizard does.
class ShopPhotoPreviewPicker extends StatelessWidget {
  const ShopPhotoPreviewPicker({
    super.key,
    this.localPath,
    this.remoteUrl,
    required this.onPicked,
    required this.onRemoved,
    this.isDisabled = false,
    this.isUploading = false,
  });

  /// A file the owner just picked, shown while it uploads. Takes precedence
  /// over [remoteUrl]: it is the newer of the two, and it needs no network.
  final String? localPath;

  /// What the server has, once the upload has landed.
  final String? remoteUrl;

  final ValueChanged<XFile> onPicked;
  final VoidCallback onRemoved;

  final bool isDisabled;
  final bool isUploading;

  bool get _hasPhoto => localPath != null || remoteUrl != null;

  static const double _height = 150;

  /// Big enough for a shop card, small enough not to spend a minute uploading
  /// on a phone connection once there is somewhere to upload to.
  static const int _maxDimension = 1600;
  static const int _quality = 85;

  Future<void> _pick(BuildContext context, ImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: _maxDimension.toDouble(),
        maxHeight: _maxDimension.toDouble(),
        imageQuality: _quality,
      );
      // Backing out of the picker is a decision, not a failure: leave whatever
      // was already chosen alone.
      if (picked != null) onPicked(picked);
    } catch (error, stackTrace) {
      AppLogger.error(
        '[shop] could not read the picked photo',
        error,
        stackTrace,
      );
      if (context.mounted) {
        AppSnackBar.error(context, context.t.shopSetup.shop.photoFailed);
      }
    }
  }

  Future<void> _openSourceSheet(BuildContext context) async {
    final choice = await AppBottomSheet.show<_PhotoAction>(
      context,
      builder: (context) =>
          _PhotoActions(localPath: localPath, remoteUrl: remoteUrl),
    );
    if (choice == null || !context.mounted) return;

    switch (choice) {
      case _PhotoAction.camera:
        await _pick(context, ImageSource.camera);
      case _PhotoAction.gallery:
        await _pick(context, ImageSource.gallery);
      case _PhotoAction.remove:
        onRemoved();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.shop;
    final onTap = isDisabled || isUploading
        ? null
        : () => _openSourceSheet(context);

    if (!_hasPhoto) {
      return DashedPanel(
        height: _height,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: context.spacing.huge.w,
              height: context.spacing.huge.w,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.photo_camera_outlined,
                size: context.icons.m.w,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: context.spacing.md.h),
            Text(t.photoAdd, style: context.textTheme.titleSmall),
            SizedBox(height: context.spacing.xs.h),
            Text(
              t.photoHint,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return AppPressScale.tap(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: context.radii.lgR,
        child: SizedBox(
          height: _height.h,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (localPath != null)
                Image.file(
                  File(localPath!),
                  fit: BoxFit.cover,
                  // A file that vanished between picking and painting should
                  // not take the step down with it.
                  errorBuilder: (context, error, _) => const _BrokenPhoto(),
                )
              else
                Image.network(
                  remoteUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, _) => const _BrokenPhoto(),
                ),

              // Dim and spin over the photo rather than replacing it: the
              // owner should keep seeing what they picked while it uploads.
              if (isUploading) ...[
                ColoredBox(
                  color: context.colorScheme.scrim.withOpacityValue(0.4),
                ),
                const Center(child: AppLoader()),
              ],
              // The photo is usually busy, so the affordance needs its own
              // backing rather than relying on contrast with whatever is
              // underneath it.
              if (!isUploading)
                Positioned(
                  right: context.spacing.sm.w,
                  bottom: context.spacing.sm.h,
                  child: _EditChip(label: context.t.common.edit),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrokenPhoto extends StatelessWidget {
  const _BrokenPhoto();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.broken_image_outlined,
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _EditChip extends StatelessWidget {
  const _EditChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.md.w,
        vertical: context.spacing.xs.h,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: context.radii.pillR,
        boxShadow: context.shadows.sm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.edit_outlined, size: context.icons.s.w),
          SizedBox(width: context.spacing.xs.w),
          Text(label, style: context.textTheme.labelLarge),
        ],
      ),
    );
  }
}

enum _PhotoAction { camera, gallery, remove }

class _PhotoActions extends StatelessWidget {
  const _PhotoActions({this.localPath, this.remoteUrl});

  final String? localPath;
  final String? remoteUrl;

  bool get _hasPhoto => localPath != null || remoteUrl != null;

  @override
  Widget build(BuildContext context) => _hasPhoto
      ? _Replace(localPath: localPath, remoteUrl: remoteUrl)
      : const _FirstPhoto();
}

/// Nothing chosen yet: the two sources get room to argue for themselves, and
/// the tips are worth reading before the camera opens.
class _FirstPhoto extends StatelessWidget {
  const _FirstPhoto();

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.shop;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(t.photoSource, style: context.textTheme.headlineSmall),
          SizedBox(height: context.spacing.xs.h),
          Text(
            t.photoSourceBody,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.spacing.lg.h),

          // Two sources, side by side and equal: the camera leads because a
          // shop photo taken now beats one found in a gallery, but choosing
          // from the library is not a lesser option.
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _SourceCard(
                    icon: Icons.photo_camera_outlined,
                    label: t.photoCamera,
                    isPrimary: true,
                    onTap: () => Navigator.of(context).pop(_PhotoAction.camera),
                  ),
                ),
                SizedBox(width: context.spacing.md.w),
                Expanded(
                  child: _SourceCard(
                    icon: Icons.image_outlined,
                    label: t.photoGallery,
                    onTap: () =>
                        Navigator.of(context).pop(_PhotoAction.gallery),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: context.spacing.lg.h),
          _PhotoTips(
            title: t.photoTipsTitle,
            tips: [t.photoTipLight, t.photoTipLandscape, t.photoTipFaces],
          ),

          SizedBox(height: context.spacing.lg.h),
          AppOutlinedButton(
            label: context.t.common.cancel,
            expand: true,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

/// A photo is already set, so the question is narrower: swap it or drop it.
///
/// The thumbnail answers "which photo?" without making the owner close the
/// sheet to look, and the three actions are one grouped list because they are
/// alternatives to each other rather than a choice plus an escape hatch.
class _Replace extends StatelessWidget {
  const _Replace({this.localPath, this.remoteUrl});

  final String? localPath;
  final String? remoteUrl;

  static const double _thumbnail = 64;

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.shop;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: context.radii.mdR,
                child: SizedBox(
                  width: _thumbnail.w,
                  height: _thumbnail.w,
                  child: localPath != null
                      ? Image.file(
                          File(localPath!),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, _) =>
                              const _BrokenPhoto(),
                        )
                      : Image.network(
                          remoteUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, _) =>
                              const _BrokenPhoto(),
                        ),
                ),
              ),
              SizedBox(width: context.spacing.lg.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(t.photoSource, style: context.textTheme.titleLarge),
                    SizedBox(height: context.spacing.xxs.h),
                    Text(
                      t.photoVisible,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: context.spacing.lg.h),
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest,
              borderRadius: context.radii.lgR,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                _SheetRow(
                  icon: Icons.photo_camera_outlined,
                  label: t.photoCameraNew,
                  onTap: () => Navigator.of(context).pop(_PhotoAction.camera),
                ),
                const _RowDivider(),
                _SheetRow(
                  icon: Icons.image_outlined,
                  label: t.photoGallery,
                  onTap: () => Navigator.of(context).pop(_PhotoAction.gallery),
                ),
                const _RowDivider(),
                _SheetRow(
                  icon: Icons.delete_outline,
                  label: t.photoRemove,
                  isDestructive: true,
                  onTap: () => Navigator.of(context).pop(_PhotoAction.remove),
                ),
              ],
            ),
          ),

          SizedBox(height: context.spacing.lg.h),
          AppOutlinedButton(
            label: context.t.common.cancel,
            expand: true,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class _SheetRow extends StatelessWidget {
  const _SheetRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final colour = isDestructive
        ? context.colorScheme.error
        : context.colorScheme.onSurface;

    return AppPressScale(
      builder: (context, states) => InkWell(
        onTap: onTap,
        statesController: states,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing.lg.w,
            vertical: context.spacing.lg.h,
          ),
          child: Row(
            children: [
              Icon(icon, size: context.icons.m.w, color: colour),
              SizedBox(width: context.spacing.md.w),
              Expanded(
                child: Text(
                  label,
                  style: context.textTheme.bodyLarge?.copyWith(color: colour),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return AppDivider.inset();
  }
}

class _SourceCard extends StatelessWidget {
  const _SourceCard({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  /// Tinted, with a filled disc — the recommended way in.
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final disc = isPrimary
        ? context.colorScheme.primary
        : context.colorScheme.surface;
    final onDisc = isPrimary
        ? context.colorScheme.onPrimary
        : context.colorScheme.onSurface;

    return AppPressScale(
      builder: (context, states) => InkWell(
        onTap: onTap,
        statesController: states,
        borderRadius: context.radii.lgR,
        child: Container(
          padding: EdgeInsets.all(context.spacing.lg.w),
          decoration: BoxDecoration(
            color: isPrimary
                ? context.decorations.blobWarm
                : context.colorScheme.surfaceContainerHighest,
            borderRadius: context.radii.lgR,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: context.spacing.xxl.w,
                height: context.spacing.xxl.w,
                decoration: BoxDecoration(color: disc, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(icon, size: context.icons.s.w, color: onDisc),
              ),
              SizedBox(height: context.spacing.lg.h),
              Text(label, style: context.textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoTips extends StatelessWidget {
  const _PhotoTips({required this.title, required this.tips});

  final String title;
  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.lg.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: context.radii.lgR,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title.toUpperCase(),
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.spacing.md.h),
          for (final tip in tips)
            Padding(
              padding: EdgeInsets.only(bottom: context.spacing.sm.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    size: context.icons.s.w,
                    color: context.colorScheme.primary,
                  ),
                  SizedBox(width: context.spacing.md.w),
                  Expanded(
                    child: Text(tip, style: context.textTheme.bodyMedium),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
