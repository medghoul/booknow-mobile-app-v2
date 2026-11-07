import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/shop_map_preview.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/shop_setup_chrome.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The address, as one row that reopens the picker.
///
/// Not a text field, unlike the name and the phone beside it. An address the
/// owner can type is an address with no coordinates, and a shop with no pin
/// is a shop no customer can find — so the only way to change it is to pick
/// a suggestion again, and the row is the door to that.
class ShopAddressField extends StatelessWidget {
  const ShopAddressField({super.key, required this.address, this.onTap});

  final ShopAddress? address;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.details;
    final address = this.address;

    final row = Container(
      constraints: BoxConstraints(minHeight: AppComponentSizes.fieldHeight.h),
      decoration: context.decorations.cardFlat.copyWith(
        borderRadius: context.radii.mdR,
        border: Border.all(
          color: context.colorScheme.outlineVariant,
          width: AppComponentSizes.settingsThumbBorderWidth,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.lg.w,
        vertical: context.spacing.sm.h,
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.location_on_outlined,
              size: 20.w,
              color: context.colorScheme.primary,
            ),
          ),
          SizedBox(width: context.spacing.md.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  address?.line ?? t.addressMissing,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleSmall,
                ),
                SizedBox(height: context.spacing.xxs.h),
                Text(
                  _secondLine(context, address),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (onTap != null) ...[
            SizedBox(width: context.spacing.md.w),
            Icon(
              Icons.chevron_right_rounded,
              size: context.icons.s.w,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ],
        ],
      ),
    );

    if (onTap == null) return Semantics(container: true, child: row);

    return Semantics(
      button: true,
      container: true,
      child: AppPressScale.tap(onTap: onTap, child: row),
    );
  }

  /// "00186 Roma · pin sulla mappa", or the half of it that is true.
  static String _secondLine(BuildContext context, ShopAddress? address) {
    final t = context.t.shopSetup.details;
    if (address == null) return t.addressMissingHelper;

    final place = [
      address.zip,
      address.city,
    ].where((part) => part.isNotEmpty).join(' ');
    final pin = address.isGeocoded ? t.addressPinned : t.addressNotPinned;

    return place.isEmpty ? pin : '$place · $pin';
  }
}

/// The picker, over the screen that asked for it.
///
/// A sheet rather than a route so it shares the one [ShopSetupCubit]: picking
/// a suggestion saves the address through it, and the screen underneath is
/// already showing the new one by the time this closes.
class ShopAddressSheet extends StatefulWidget {
  const ShopAddressSheet({super.key});

  static Future<void> open(BuildContext context) => AppBottomSheet.show<void>(
    context,
    title: context.t.shopSetup.details.addressLabel,
    builder: (_) => BlocProvider.value(
      value: context.read<ShopSetupCubit>(),
      child: const ShopAddressSheet(),
    ),
  );

  @override
  State<ShopAddressSheet> createState() => _ShopAddressSheetState();
}

class _ShopAddressSheetState extends State<ShopAddressSheet> {
  late final TextEditingController _query = TextEditingController(
    text: context.read<ShopSetupCubit>().state.shop?.address?.line ?? '',
  );

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup;
    final cubit = context.read<ShopSetupCubit>();
    final state = context.watch<ShopSetupCubit>().state;
    final address = state.shop?.address;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSearchField(
          controller: _query,
          hint: t.address.searchHint,
          clearTooltip: context.t.common.clear,
          onChanged: cubit.searchAddresses,
        ),
        if (state.suggestions.isNotEmpty) ...[
          SizedBox(height: context.spacing.sm.h),
          Flexible(
            child: SingleChildScrollView(
              child: Container(
                decoration: context.decorations.card,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final (index, suggestion)
                        in state.suggestions.indexed) ...[
                      if (index > 0) const AppDivider(),
                      _SuggestionRow(
                        suggestion: suggestion,
                        onTap: state.isSaving
                            ? null
                            : () => cubit.chooseAddress(suggestion.placeId),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ] else ...[
          SizedBox(height: context.spacing.lg.h),
          if (address != null && address.isGeocoded)
            ShopMapPreview(address: address)
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
        ],
        SizedBox(height: context.spacing.lg.h),
        AppElevatedButton(
          label: context.t.common.save,
          expand: true,
          isLoading: state.isSaving,
          isDisabled: !(address?.isGeocoded ?? false),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow({required this.suggestion, required this.onTap});

  final PlaceSuggestion suggestion;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressScale(
      builder: (context, states) => InkWell(
        onTap: onTap,
        statesController: states,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing.lg.w,
            vertical: context.spacing.md.h,
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: context.icons.s.w,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: context.spacing.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(suggestion.label, style: context.textTheme.titleSmall),
                    if (suggestion.secondaryLabel != null)
                      Text(
                        suggestion.secondaryLabel!,
                        style: context.textTheme.bodySmall?.copyWith(
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
