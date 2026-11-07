import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/utils/validation/form_validators.dart';
import 'package:booknow_mobile/domain/models/shop.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_state.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/shop_setup_chrome.dart';
import 'package:image_picker/image_picker.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/shop_photo_preview_picker.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/shop_map_preview.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Step 1 — name and phone, each with one line saying who sees it.
///
/// The photo is the only optional field and is visibly so: a large dashed drop
/// area that says "puoi farlo dopo", so skipping reads as allowed rather than
/// as something left undone.
class ShopDetailsStep extends StatefulWidget {
  const ShopDetailsStep({super.key, required this.shop});

  final Shop? shop;

  @override
  State<ShopDetailsStep> createState() => _ShopDetailsStepState();
}

class _ShopDetailsStepState extends State<ShopDetailsStep> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _phone;

  /// `image_picker` does not report a MIME type, and the API only signs an
  /// upload for three. The extension is the only hint there is; anything else
  /// is sent as JPEG, which is what a phone camera produces.
  static String _contentTypeOf(XFile file) =>
      switch (file.path.split('.').last.toLowerCase()) {
        'png' => 'image/png',
        'webp' => 'image/webp',
        _ => 'image/jpeg',
      };

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.shop?.name ?? '');
    _phone = TextEditingController(text: widget.shop?.phone ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<ShopSetupCubit>().saveShopDetails(
      name: _name.text.trim(),
      phone: _phone.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup;
    final cubit = context.read<ShopSetupCubit>();
    final state = context.watch<ShopSetupCubit>().state;
    final isSaving = state.isSaving;

    return Form(
      key: _formKey,
      child: AppDockedColumn(
        docked: AppElevatedButton(
          label: context.t.common.save,
          expand: true,
          isLoading: isSaving,
          onPressed: _submit,
        ),
        children: [
          ShopSetupHeading(title: t.shop.title),
          SizedBox(height: context.spacing.lg.h),
          ShopPhotoPreviewPicker(
            localPath: state.pendingPhotoPath,
            remoteUrl: state.shop?.photoUrl,
            isDisabled: isSaving,
            isUploading: state.isUploadingPhoto,
            onPicked: (picked) => cubit.uploadPhoto(
              filePath: picked.path,
              contentType: _contentTypeOf(picked),
            ),
            onRemoved: cubit.removePhoto,
          ),
          SizedBox(height: context.spacing.lg.h),

          AppFieldLabel(label: t.shop.nameLabel),
          AppTextField(
            controller: _name,
            textInputAction: TextInputAction.next,
            validator: FormValidators.required,
          ),
          AppFieldHelper(t.shop.nameHelper),
          SizedBox(height: context.spacing.lg.h),

          AppFieldLabel(label: t.shop.phoneLabel),
          AppPhoneField(
            controller: _phone,
            textInputAction: TextInputAction.done,
            validator: (value) => FormValidators.phone(value, isRequired: true),
          ),
          AppFieldHelper(t.shop.phoneHelper),
          SizedBox(height: context.spacing.xl.h),
        ],
      ),
    );
  }
}

/// Step 2 — address, chosen from suggestions only.
///
/// Continue stays disabled until a suggestion has been picked: free text
/// cannot be geocoded reliably, and a shop with no coordinates can never be
/// found by a customer.
class ShopAddressStep extends StatefulWidget {
  const ShopAddressStep({super.key, required this.shop});

  final Shop? shop;

  @override
  State<ShopAddressStep> createState() => _ShopAddressStepState();
}

class _ShopAddressStepState extends State<ShopAddressStep> {
  late final TextEditingController _query = TextEditingController(
    text: widget.shop?.address?.line ?? '',
  );

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopSetupCubit, ShopSetupState>(
      listenWhen: (previous, current) =>
          previous.shop?.address?.line != current.shop?.address?.line,
      listener: (context, state) {
        final line = state.shop?.address?.formatted;
        if (line != null && line.isNotEmpty) _query.text = line;
      },
      child: _buildStep(context),
    );
  }

  Widget _buildStep(BuildContext context) {
    final t = context.t.shopSetup;
    final cubit = context.read<ShopSetupCubit>();
    final state = context.watch<ShopSetupCubit>().state;
    final address = state.shop?.address;
    final hasPin = address?.isGeocoded ?? false;

    return AppDockedColumn(
      docked: AppElevatedButton(
        label: t.checklist.done,
        expand: true,
        isLoading: state.isSaving,
        isDisabled: !hasPin,
        onPressed: () => cubit.goToServices(),
      ),
      children: [
        ShopSetupHeading(title: t.address.title),
        SizedBox(height: context.spacing.lg.h),

        AppSearchField(
          controller: _query,
          hint: t.address.searchHint,
          clearTooltip: context.t.common.clear,
          onChanged: cubit.searchAddresses,
        ),

        if (state.suggestions.isNotEmpty) ...[
          SizedBox(height: context.spacing.sm.h),
          Container(
            decoration: context.decorations.card,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (var i = 0; i < state.suggestions.length; i++) ...[
                  if (i > 0) AppDivider(),
                  _SuggestionRow(
                    suggestion: state.suggestions[i],
                    isSelected: address?.line == state.suggestions[i].label,
                    onTap: state.isSaving
                        ? null
                        : () =>
                              cubit.chooseAddress(state.suggestions[i].placeId),
                  ),
                ],
              ],
            ),
          ),
        ],

        SizedBox(height: context.spacing.lg.h),
        if (hasPin)
          ShopMapPreview(address: address!)
        else
          DashedPanel(
            height: AppComponentSizes.mapPreviewHeight,
            child: Text(
              t.address.mapPreview,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        AppFieldHelper(t.address.helper),
        SizedBox(height: context.spacing.xl.h),
      ],
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow({
    required this.suggestion,
    required this.isSelected,
    required this.onTap,
  });

  final dynamic suggestion;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressScale(
      builder: (context, states) => InkWell(
        onTap: onTap,
        statesController: states,
        child: Container(
          color: isSelected
              ? context.colorScheme.surfaceContainerHighest
              : Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing.lg.w,
            vertical: context.spacing.md.h,
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: context.icons.s.w,
                color: context.colorScheme.secondary,
              ),
              SizedBox(width: context.spacing.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      suggestion.label as String,
                      style: context.textTheme.titleSmall,
                    ),
                    if (suggestion.secondaryLabel != null)
                      Text(
                        suggestion.secondaryLabel as String,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
