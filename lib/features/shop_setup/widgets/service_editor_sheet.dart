import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/utils/validation/form_validators.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/service_duration_chips.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One service: its name, how long it takes, what it costs.
///
/// A sheet rather than a route so it shares the one [ShopSetupCubit] with the
/// list behind it — saving goes through that cubit, which re-reads the shop,
/// so the row underneath is already correct when this closes. A second route
/// would need a second cubit over the same endpoints and a reload on the way
/// back.
///
/// The design's visibility switch is not here: the API has no hidden flag, so
/// a switch would be a control that changes nothing. See [ServiceActionsSheet]
/// for the same gap on the actions list.
class ServiceEditorSheet extends StatefulWidget {
  const ServiceEditorSheet({super.key, this.service});

  /// The service being changed, or null to add one.
  final ShopService? service;

  /// Opens the editor and resolves to true once the server has the service.
  static Future<bool?> open(BuildContext context, {ShopService? service}) {
    final t = context.t.shopSetup.services;

    return AppBottomSheet.show<bool>(
      context,
      title: service == null ? t.newService : t.editTitle,
      builder: (_) => BlocProvider.value(
        value: context.read<ShopSetupCubit>(),
        child: ServiceEditorSheet(service: service),
      ),
    );
  }

  @override
  State<ServiceEditorSheet> createState() => _ServiceEditorSheetState();
}

class _ServiceEditorSheetState extends State<ServiceEditorSheet> {
  static const int _defaultDuration = 30;

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _price;
  late int _duration;

  @override
  void initState() {
    super.initState();
    final service = widget.service;
    _name = TextEditingController(text: service?.name ?? '');
    _price = TextEditingController(
      text: service == null ? '' : _asInput(service.priceCents),
    );
    _duration = service?.durationMinutes ?? _defaultDuration;
  }

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    super.dispose();
  }

  /// Cents as the owner would type them: "25,00", not "€25,00".
  static String _asInput(int cents) =>
      (cents / 100).toStringAsFixed(2).replaceAll('.', ',');

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final saved = await context.read<ShopSetupCubit>().saveServiceDetails(
      serviceId: widget.service?.id,
      name: _name.text.trim(),
      durationMinutes: _duration,
      priceCents: Money.parseToCents(_price.text),
    );

    if (!saved || !mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.services;
    final isSaving = context.watch<ShopSetupCubit>().state.isSaving;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppFieldLabel(label: t.nameLabel),
                  AppTextField(
                    controller: _name,
                    hint: t.nameHint,
                    enabled: !isSaving,
                    textInputAction: TextInputAction.next,
                    validator: FormValidators.required,
                  ),
                  SizedBox(height: context.spacing.lg.h),

                  AppFieldLabel(label: t.durationLabel),
                  ServiceDurationChips(
                    selected: _duration,
                    isEnabled: !isSaving,
                    onSelected: (minutes) =>
                        setState(() => _duration = minutes),
                  ),
                  SizedBox(height: context.spacing.lg.h),

                  AppFieldLabel(label: t.priceLabel),
                  AppTextField(
                    controller: _price,
                    hint: t.priceHint,
                    prefixIcon: Icons.euro,
                    enabled: !isSaving,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                    ],
                    validator: FormValidators.required,
                    suffix: _PreviousPrice(
                      typed: _price,
                      current: widget.service?.priceCents,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: context.spacing.lg.h),
          AppElevatedButton(
            label: widget.service == null ? t.save : t.saveChanges,
            expand: true,
            isLoading: isSaving,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}

/// The price the service is on now, struck through, while a different one is
/// being typed.
///
/// The design shows it inside the field: changing a price is the edit an owner
/// is most likely to make by mistake, and the old one sitting beside the new
/// one is what makes a slip visible before Save. It disappears when the typed
/// value matches again, so it never contradicts the field it sits in.
///
/// Struck-through text says nothing to a screen reader, so the semantics
/// label spells it out instead.
class _PreviousPrice extends StatelessWidget {
  const _PreviousPrice({required this.typed, required this.current});

  final TextEditingController typed;

  /// What the server holds, or null for a service that does not exist yet.
  final int? current;

  @override
  Widget build(BuildContext context) {
    final current = this.current;
    if (current == null) return const SizedBox.shrink();

    return ValueListenableBuilder(
      valueListenable: typed,
      builder: (context, value, _) {
        if (Money.parseToCents(value.text) == current) {
          return const SizedBox.shrink();
        }

        final price = Money.formatCents(current);
        return Padding(
          padding: EdgeInsets.only(right: context.spacing.lg.w),
          child: Semantics(
            label: context.t.shopSetup.services.previousPrice(price: price),
            excludeSemantics: true,
            child: Text(
              price,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        );
      },
    );
  }
}
