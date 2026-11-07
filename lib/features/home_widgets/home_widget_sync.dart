import 'dart:async';

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/services/logger/app_logger.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/agenda_repository.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/home_widgets/home_widget_data.dart';
import 'package:booknow_mobile/features/queue/cubit/live_status_cubit.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';

/// Keeps the phone's home screen widgets up to date while the app is running.
///
/// It reads for itself rather than listening to each screen's cubit: the
/// widgets need the next booking whether or not Activity has been opened. Once
/// the app is closed nothing writes, which is why the values carry an expiry.
class HomeWidgetSync with WidgetsBindingObserver {
  HomeWidgetSync({
    required AuthCubit auth,
    required LiveStatusCubit live,
    required BookingRepository bookings,
    required QueueRepository queue,
    required AgendaRepository agenda,
  }) : _auth = auth,
       _live = live,
       _bookings = bookings,
       _queue = queue,
       _agenda = agenda;

  final AuthCubit _auth;
  final LiveStatusCubit _live;
  final BookingRepository _bookings;
  final QueueRepository _queue;
  final AgendaRepository _agenda;

  static const String _package = 'com.booknow.widget';
  static const List<String> _customerWidgets = [
    '$_package.CustomerSmallWidget',
    '$_package.CustomerMediumWidget',
  ];
  static const List<String> _ownerWidgets = [
    '$_package.OwnerSmallWidget',
    '$_package.OwnerMediumWidget',
    '$_package.OwnerLargeWidget',
  ];

  /// Every value a widget may read, so one left over from a longer list or
  /// another account is cleared rather than shown.
  static final List<String> _slots = [
    'overline',
    'big',
    'caption',
    'title',
    'line',
    'foot',
    'summary',
    'tone',
    'action',
    'geo',
    'freshUntil',
    'stale',
    for (var row = 1; row <= 4; row++) ...[
      'row${row}Lead',
      'row${row}Name',
      'row${row}Line',
    ],
  ];

  static const Duration _every = Duration(minutes: 2);

  Timer? _timer;
  StreamSubscription<Object?>? _authChanges;
  StreamSubscription<Object?>? _liveChanges;
  bool _started = false;

  void start() {
    // The native widgets only exist on Android so far.
    if (_started || defaultTargetPlatform != TargetPlatform.android) return;
    _started = true;

    WidgetsBinding.instance.addObserver(this);
    _authChanges = _auth.stream
        .map((state) => (state.profile?.role, state.shop?.mode))
        .distinct()
        .listen((_) => unawaited(refresh()));
    _liveChanges = _live.stream.listen((_) => unawaited(refresh()));
    _resume();
    unawaited(refresh());
  }

  void stop() {
    if (!_started) return;
    _started = false;
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _timer = null;
    unawaited(_authChanges?.cancel());
    unawaited(_liveChanges?.cancel());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _resume();
      unawaited(refresh());
    } else if (state == AppLifecycleState.paused) {
      _timer?.cancel();
      _timer = null;
    }
  }

  void _resume() =>
      _timer ??= Timer.periodic(_every, (_) => unawaited(refresh()));

  /// Writes what is true now. A failed read leaves the last values in place:
  /// they carry their own expiry, and blanking them would be worse.
  Future<void> refresh() async {
    try {
      final auth = _auth.state;
      final now = DateTime.now().toUtc();

      if (auth.profile?.role == UserRole.owner) {
        final values = await _ownerValues(now);
        if (values != null) await _write('o', values, _ownerWidgets);
        await _write('c', const {}, _customerWidgets);
        return;
      }

      final values = await _customerValues(now, signedIn: auth.session != null);
      if (values != null) await _write('c', values, _customerWidgets);
      await _write('o', const {}, _ownerWidgets);
    } on Exception catch (error) {
      // No launcher support, or a plugin not attached. Widgets are a bonus.
      AppLogger.error('[home widgets] update failed', error);
    }
  }

  Future<WidgetValues?> _customerValues(
    DateTime now, {
    required bool signedIn,
  }) async {
    final locale = LocaleSettings.currentLocale.languageCode;
    if (!signedIn) {
      return customerWidgetValues(
        t: t,
        locale: locale,
        now: now,
        entry: null,
        upcoming: const [],
        past: const [],
      );
    }

    final (upcoming, past) = await (
      _bookings.list(BookingScope.upcoming),
      _bookings.list(BookingScope.past),
    ).wait;
    if (upcoming is! Success<List<Booking>> ||
        past is! Success<List<Booking>>) {
      return null;
    }

    return customerWidgetValues(
      t: t,
      locale: locale,
      now: now,
      entry: _live.state,
      upcoming: upcoming.data,
      past: past.data,
    );
  }

  Future<WidgetValues?> _ownerValues(DateTime now) async {
    final shop = _auth.state.shop;
    if (shop == null) return null;
    final name = shop.name ?? '';

    if (shop.mode.runsQueue) {
      final queue = await _queue.ownerQueue();
      return queue is Success<OwnerQueue>
          ? ownerQueueWidgetValues(
              t: t,
              now: now,
              shopName: name,
              queue: queue.data,
            )
          : null;
    }

    final day = await _agenda.day();
    return day is Success<AgendaDay>
        ? ownerDayWidgetValues(
            t: t,
            locale: LocaleSettings.currentLocale.languageCode,
            now: now,
            shopName: name,
            day: day.data,
          )
        : null;
  }

  Future<void> _write(
    String prefix,
    WidgetValues values,
    List<String> widgets,
  ) async {
    await Future.wait([
      for (final slot in _slots)
        HomeWidget.saveWidgetData<String>('${prefix}_$slot', values[slot]),
    ]);
    await Future.wait([
      for (final widget in widgets)
        HomeWidget.updateWidget(qualifiedAndroidName: widget),
    ]);
  }
}
