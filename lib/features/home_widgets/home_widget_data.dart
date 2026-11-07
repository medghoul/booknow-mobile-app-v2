import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:intl/intl.dart';

/// What the phone's home screen widgets show, as finished strings.
///
/// The native side only places text: every word and date is decided here, so
/// the widgets speak the app's language and there is one copy of the rules.
///
/// A widget cannot read the API. It shows what the app last wrote, so each set
/// of values says how long it can be believed (`freshUntil`) and what to say
/// after that (`stale`), and a place in line never goes on claiming "#3" hours
/// after the customer was served.
typedef WidgetValues = Map<String, String>;

const Duration _liveFor = Duration(minutes: 30);
const Duration _planFor = Duration(hours: 2);

/// Far enough ahead that a suggestion never goes stale: it is not a claim.
DateTime _never(DateTime now) => now.add(const Duration(days: 3650));

String _until(DateTime when) => when.millisecondsSinceEpoch.toString();

/// The customer's widgets: a place in line first, then the next visit, then
/// the shops they might go back to.
WidgetValues customerWidgetValues({
  required Translations t,
  required String locale,
  required DateTime now,
  required QueueEntry? entry,
  required List<Booking> upcoming,
  required List<Booking> past,
}) {
  final w = t.homeWidgets;

  if (entry != null) {
    final geo = _geo(entry.shopName, null);
    final shop = entry.shopName ?? '';

    if (entry.status == QueueEntryStatus.called) {
      return {
        'overline': shop,
        'title': t.queue.turnTitle,
        'line': w.headIn,
        'tone': 'green',
        'action': w.directions,
        'geo': geo,
        'freshUntil': _until(
          entry.noShowFrom ?? now.add(const Duration(minutes: 10)),
        ),
        'stale': w.staleQueue,
      };
    }

    if (entry.status == QueueEntryStatus.serving) {
      return {
        'overline': shop,
        'title': t.live.inChair,
        'line': entry.serviceName,
        'freshUntil': _until(now.add(_liveFor)),
        'stale': w.staleQueue,
      };
    }

    final estimate = entry.estimate;
    final range = estimate == null
        ? ''
        : t.queue.range(from: estimate.fromMin, to: estimate.toMin);
    final position = entry.position;
    final ahead = entry.aheadCount;

    return {
      'overline': w.inLine,
      'big': position == null ? '' : t.queue.position(n: position),
      'caption': range,
      'title': shop,
      'line': [entry.serviceName, range].where(_filled).join(' · '),
      'foot': ahead == null ? '' : w.ahead(n: ahead),
      'action': w.directions,
      'geo': geo,
      'freshUntil': _until(now.add(_liveFor)),
      'stale': w.staleQueue,
    };
  }

  final next = upcoming
      .where((booking) => booking.status == BookingStatus.confirmed)
      .firstOrNull;
  if (next != null) {
    final wall = ShopClock.wallTime(next.startUtc, next.timeZone);

    return {
      'overline': w.nextVisit,
      'big': DateFormat('E d', locale).format(wall),
      'caption': ShopClock.hm(next.startUtc, next.timeZone, locale),
      'title': next.shopName ?? '',
      'line': next.serviceName,
      'action': w.directions,
      'geo': _geo(next.shopName, next.shopAddressLine),
      'freshUntil': _until(next.startUtc),
      'stale': w.staleBooking,
    };
  }

  // Each shop once, however many times they went.
  final usual = past
      .map((booking) => booking.shopName)
      .whereType<String>()
      .toSet()
      .take(2)
      .toList();

  return {
    'overline': usual.isEmpty ? 'BookNow' : w.bookAgain,
    'title': usual.isEmpty ? w.findTitle : usual.first,
    'line': usual.isEmpty ? w.findLine : usual.skip(1).firstOrNull ?? '',
    'freshUntil': _until(_never(now)),
    'stale': w.findLine,
  };
}

/// The owner's widgets for a shop running a queue.
WidgetValues ownerQueueWidgetValues({
  required Translations t,
  required DateTime now,
  required String shopName,
  required OwnerQueue queue,
}) {
  final w = t.homeWidgets;
  final state = switch (queue.state) {
    QueueState.open => t.today.stateOpenTitle,
    QueueState.paused => t.queue.statePaused,
    QueueState.closed => t.queue.stateClosed,
  };
  final called = queue.called;
  final next = queue.waiting.firstOrNull;
  String nameOf(OwnerQueueEntry entry) =>
      entry.customerName ?? t.queue.owner.walkInName;

  return {
    'overline': '$shopName · $state',
    'big': '${queue.waitingCount}',
    'caption': w.waiting,
    'title': called != null
        ? nameOf(called)
        : next != null
        ? nameOf(next)
        : w.nobodyWaiting,
    'line': called != null
        ? w.calledLine
        : next != null
        ? w.nextUp
        : '',
    'summary': w.waitingCount(n: queue.waitingCount),
    'action': w.openToday,
    for (final (index, entry) in queue.waiting.take(_rows).indexed) ...{
      'row${index + 1}Lead': t.queue.position(n: index + 1),
      'row${index + 1}Name': nameOf(entry),
      'row${index + 1}Line': entry.serviceName,
    },
    'freshUntil': _until(now.add(_liveFor)),
    'stale': w.staleOwner,
  };
}

/// The owner's widgets for a shop taking bookings.
WidgetValues ownerDayWidgetValues({
  required Translations t,
  required String locale,
  required DateTime now,
  required String shopName,
  required AgendaDay day,
}) {
  final w = t.homeWidgets;
  final coming = day.rows
      .whereType<AgendaBookingRow>()
      .where(
        (row) =>
            row.status == BookingStatus.confirmed && row.startUtc.isAfter(now),
      )
      .toList();
  final next = coming.firstOrNull;
  String hm(DateTime when) => ShopClock.hm(when, day.timeZone, locale);
  String nameOf(AgendaBookingRow row) =>
      row.customerName ?? t.agenda.customerFallback;

  // Bookings arrive while the app is shut, so even a far-off one is checked.
  final plan = now.add(_planFor);
  final freshUntil = next != null && next.startUtc.isBefore(plan)
      ? next.startUtc
      : plan;

  return {
    'overline': next == null ? shopName : w.nextAppointment,
    'big': next == null ? '' : hm(next.startUtc),
    'title': next == null ? w.nothingLeft : nameOf(next),
    'line': next == null
        ? ''
        : [
            next.serviceName,
            if (coming.length > 1) w.moreToday(n: coming.length - 1),
          ].join(' · '),
    'summary': t.agenda.booked(n: day.summary.booked),
    'action': w.openToday,
    for (final (index, row) in coming.take(_rows).indexed) ...{
      'row${index + 1}Lead': hm(row.startUtc),
      'row${index + 1}Name': nameOf(row),
      'row${index + 1}Line': row.serviceName,
    },
    'freshUntil': _until(freshUntil),
    'stale': w.staleOwner,
  };
}

const int _rows = 4;

bool _filled(String text) => text.isNotEmpty;

String _geo(String? name, String? address) {
  final query = Uri.encodeComponent(
    [name, address].whereType<String>().join(', '),
  );
  return 'geo:0,0?q=$query';
}
