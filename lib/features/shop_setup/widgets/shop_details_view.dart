import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/utils/validation/form_validators.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/shop_address_field.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/shop_photo_preview_picker.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Everything a customer sees about the shop, on one screen.
///
/// The same fields as setup steps 1 and 2, but not a wizard: there is no next
/// step, so the button says save and the screen goes back where it came from.
///
/// The photo and the address save the moment they change — one is an upload,
/// the other needs a pin that only the server can resolve — while the name
/// and the phone wait for Save. That is why the note above the button says
/// changes are live: for two of the four fields they already are.
class ShopDetailsView extends StatefulWidget {
  const ShopDetailsView({super.key, required this.onSaved});

  /// Called once the server has the new details.
  final VoidCallback onSaved;

  @override
  State<ShopDetailsView> createState() => _ShopDetailsViewState();
}

class _ShopDetailsViewState extends State<ShopDetailsView> {
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
    final shop = context.read<ShopSetupCubit>().state.shop;
    _name = TextEditingController(text: shop?.name ?? '');
    _phone = TextEditingController(text: shop?.phone ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final saved = await context.read<ShopSetupCubit>().saveShopInfo(
      name: _name.text.trim(),
      phone: _phone.text.trim(),
    );

    if (saved && mounted) widget.onSaved();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup;
    final cubit = context.read<ShopSetupCubit>();
    final state = context.watch<ShopSetupCubit>().state;

    return Form(
      key: _formKey,
      child: AppDockedColumn(
        // Entered from a row the owner tapped, so the fields are already
        // where they expect them — staggering them in would be a second
        // animation on top of the push.
        animate: false,
        docked: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t.details.liveNote,
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: context.spacing.sm.h),
            AppElevatedButton(
              label: context.t.common.save,
              expand: true,
              isLoading: state.isSaving,
              onPressed: _save,
            ),
          ],
        ),
        children: [
          ShopPhotoPreviewPicker(
            localPath: state.pendingPhotoPath,
            remoteUrl: state.shop?.photoUrl,
            isDisabled: state.isSaving,
            isUploading: state.isUploadingPhoto,
            onPicked: (picked) => cubit.uploadPhoto(
              filePath: picked.path,
              contentType: _contentTypeOf(picked),
            ),
            onRemoved: cubit.removePhoto,
          ),
          SizedBox(height: context.spacing.xl.h),

          AppFieldLabel(label: t.shop.nameLabel),
          AppTextField(
            controller: _name,
            textInputAction: TextInputAction.next,
            validator: FormValidators.required,
          ),
          SizedBox(height: context.spacing.xl.h),

          AppFieldLabel(label: t.shop.phoneLabel),
          AppPhoneField(
            controller: _phone,
            textInputAction: TextInputAction.done,
            validator: (value) => FormValidators.phone(value, isRequired: true),
          ),
          SizedBox(height: context.spacing.xl.h),

          AppFieldLabel(label: t.details.addressLabel),
          ShopAddressField(
            address: state.shop?.address,
            onTap: state.isSaving ? null : () => ShopAddressSheet.open(context),
          ),
          SizedBox(height: context.spacing.xl.h),
        ],
      ),
    );
  }
}
