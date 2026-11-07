import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/core/utils/validation/form_validators.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/day_hours_sheet.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/shop_hours_list.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One person on the team: their name, what they do, when they work.
///
/// A sheet over the team list for the reason [ServiceEditorSheet] gives: the
/// save goes through the list's own cubit, which reads the shop back, so the
/// row underneath is right by the time this closes.
///
/// Everything is a draft until the save, including a day of their own hours,
/// which opens the shop's day editor on the draft instead of on the shop.
class ProviderEditorSheet extends StatefulWidget {
  const ProviderEditorSheet({super.key, this.provider});

  /// The person being changed, or null to add someone.
  final ShopProvider? provider;

  /// The longest name the server takes.
  static const int nameMaxLength = 40;

  /// Opens the editor and resolves to true once the server has the change.
  static Future<bool?> open(BuildContext context, {ShopProvider? provider}) {
    final t = context.t.shopSetup.team;

    return AppBottomSheet.show<bool>(
      context,
      title: provider == null ? t.newTitle : t.editTitle,
      builder: (_) => BlocProvider.value(
        value: context.read<ShopSetupCubit>(),
        child: ProviderEditorSheet(provider: provider),
      ),
    );
  }

  @override
  State<ProviderEditorSheet> createState() => _ProviderEditorSheetState();
}

class _ProviderEditorSheetState extends State<ProviderEditorSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late ProviderType _type;

  /// Null is every service, kept apart from an empty choice.
  late Set<String>? _serviceIds;

  /// Null is the shop's hours.
  late OpeningHours? _hours;

  late List<String> _timeOff;

  /// The name the field opened with: the owner's own row shows the shop's
  /// name until it is given one, and only a real change is sent back.
  late final String _initialName;

  bool _showServiceError = false;

  @override
  void initState() {
    super.initState();
    final provider = widget.provider;
    final shop = context.read<ShopSetupCubit>().state.shop;

    _initialName = provider == null ? '' : provider.name ?? shop?.name ?? '';
    _name = TextEditingController(text: _initialName);
    _type = provider?.type ?? ProviderType.person;
    _serviceIds = provider?.serviceIds?.toSet();
    _hours = provider?.openingHours;
    _timeOff = [...?provider?.timeOff]..sort();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Shop? get _shop => context.read<ShopSetupCubit>().state.shop;

  Future<void> _save() async {
    final pickedNone = _serviceIds?.isEmpty ?? false;
    setState(() => _showServiceError = pickedNone);
    if (!(_formKey.currentState?.validate() ?? false) || pickedNone) return;

    final provider = widget.provider;
    final name = _name.text.trim();
    final active = {for (final s in _shop?.activeServices ?? []) s.id};

    final saved = await context.read<ShopSetupCubit>().saveProvider(
      providerId: provider?.id,
      name: provider == null || name != _initialName ? name : null,
      type: provider == null || _type != provider.type ? _type : null,
      // Only services still offered: one deleted since this opened would be
      // refused, and the owner could not see it to take it off.
      serviceIds: _serviceIds?.where(active.contains).toList(),
      openingHours: _hours,
      timeOff: _timeOff,
    );

    if (!saved || !mounted) return;
    Navigator.of(context).pop(true);
  }

  void _toggleEveryService(bool every) => setState(() {
    _showServiceError = false;
    _serviceIds = every
        ? null
        : {for (final s in _shop?.activeServices ?? <ShopService>[]) s.id};
  });

  void _toggleService(String serviceId) => setState(() {
    _showServiceError = false;
    final next = {...?_serviceIds};
    if (!next.remove(serviceId)) next.add(serviceId);
    _serviceIds = next;
  });

  /// Their own week starts as a copy of the shop's, so the owner trims a day
  /// rather than building seven from nothing.
  void _toggleShopHours(bool same) => setState(() {
    _hours = same ? null : (_shop?.openingHours ?? const OpeningHours());
  });

  Future<void> _editDay(Weekday day) async {
    final hours = _hours;
    if (hours == null) return;

    await DayHoursSheet.openDraft(
      context,
      day: day,
      hours: hours,
      onChanged: (next) => setState(() => _hours = next),
    );
  }

  Future<void> _addDayOff() async {
    final today = DateUtils.dateOnly(DateTime.now());
    final picked = await showDatePicker(
      context: context,
      firstDate: today,
      lastDate: today.add(const Duration(days: 365)),
    );
    if (picked == null || !mounted) return;

    final date = DateFormat('yyyy-MM-dd').format(picked);
    if (_timeOff.contains(date)) return;
    setState(() => _timeOff = [..._timeOff, date]..sort());
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.team;
    final isSaving = context.watch<ShopSetupCubit>().state.isSaving;
    final services = _shop?.activeServices ?? const <ShopService>[];
    final locale = Localizations.localeOf(context).toString();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // A day off already behind them is kept, so saving does not quietly
    // rewrite the past, but there is nothing to do about it on screen.
    final upcoming = _timeOff.where((d) => d.compareTo(today) >= 0).toList();
    final hours = _hours;

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
                    helper: t.nameHelper,
                    enabled: !isSaving,
                    maxLength: ProviderEditorSheet.nameMaxLength,
                    textInputAction: TextInputAction.done,
                    validator: FormValidators.required,
                  ),
                  SizedBox(height: context.spacing.lg.h),

                  AppFieldLabel(label: t.typeLabel),
                  AppSegmentedControl<ProviderType>(
                    segments: [
                      AppSegment(
                        value: ProviderType.person,
                        label: t.typePerson,
                      ),
                      AppSegment(
                        value: ProviderType.resource,
                        label: t.typeResource,
                      ),
                    ],
                    value: _type,
                    onChanged: (type) => setState(() => _type = type),
                  ),
                  SizedBox(height: context.spacing.xl.h),

                  AppFieldLabel(label: t.servicesLabel),
                  _SwitchRow(
                    label: t.everyService,
                    helper: t.everyServiceHelper,
                    value: _serviceIds == null,
                    onChanged: isSaving ? null : _toggleEveryService,
                  ),
                  if (_serviceIds != null) ...[
                    SizedBox(height: context.spacing.sm.h),
                    Wrap(
                      spacing: context.spacing.sm.w,
                      runSpacing: context.spacing.sm.h,
                      children: [
                        for (final service in services)
                          FilterChip(
                            label: Text(service.name),
                            selected: _serviceIds!.contains(service.id),
                            onSelected: isSaving
                                ? null
                                : (_) => _toggleService(service.id),
                          ),
                      ],
                    ),
                    if (_showServiceError) ...[
                      SizedBox(height: context.spacing.xs.h),
                      Text(
                        t.noService,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.error,
                        ),
                      ),
                    ],
                  ],
                  SizedBox(height: context.spacing.xl.h),

                  AppFieldLabel(label: t.hoursLabel),
                  _SwitchRow(
                    label: t.sameAsShop,
                    helper: hours == null ? null : t.ownHoursHelper,
                    value: hours == null,
                    onChanged: isSaving ? null : _toggleShopHours,
                  ),
                  if (hours != null) ...[
                    SizedBox(height: context.spacing.sm.h),
                    AppSettingsCard(
                      children: [
                        for (final day in Weekday.values)
                          ShopDayRow(
                            day: day,
                            ranges: hours.rangesOn(day),
                            onTap: isSaving ? null : () => _editDay(day),
                          ),
                      ],
                    ),
                  ],
                  SizedBox(height: context.spacing.xl.h),

                  AppFieldLabel(label: t.daysOffLabel),
                  if (upcoming.isEmpty)
                    Text(
                      t.noDaysOff,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    )
                  else
                    Wrap(
                      spacing: context.spacing.sm.w,
                      runSpacing: context.spacing.sm.h,
                      children: [
                        for (final date in upcoming)
                          InputChip(
                            label: Text(
                              DateFormat(
                                'EEE d MMM',
                                locale,
                              ).format(ShopClock.calendarDay(date)),
                            ),
                            deleteButtonTooltipMessage: t.removeDayOff(
                              day: ShopClock.dayTitle(date, locale),
                            ),
                            onDeleted: isSaving
                                ? null
                                : () => setState(
                                    () =>
                                        _timeOff = [..._timeOff]..remove(date),
                                  ),
                          ),
                      ],
                    ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AppTextButton(
                      label: t.addDayOff,
                      icon: Icons.add_rounded,
                      onPressed: isSaving ? null : _addDayOff,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: context.spacing.lg.h),
          AppElevatedButton(
            label: widget.provider == null ? t.save : t.saveChanges,
            expand: true,
            isLoading: isSaving,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}

/// A setting that is either the shop's or the person's own.
class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
    this.helper,
  });

  final String label;
  final String? helper;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: context.textTheme.titleSmall),
              if (helper != null)
                Text(
                  helper!,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: context.spacing.md.w),
        AppSwitch(value: value, onChanged: onChanged, semanticLabel: label),
      ],
    );
  }
}
