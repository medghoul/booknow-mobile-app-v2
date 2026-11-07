import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/data/dtos/coercion.dart';
import 'package:booknow_mobile/domain/models/queue.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_dto.freezed.dart';
part 'queue_dto.g.dart';

/// `{ fromMin, toMin }`, or null when either end is missing.
WaitRange? readWaitRange(Object? json) {
  final map = asMap(json);
  if (!map.containsKey('fromMin') || !map.containsKey('toMin')) return null;
  return WaitRange(fromMin: asInt(map['fromMin']), toMin: asInt(map['toMin']));
}

/// The customer's own entry, from the join, leave, `/me/queue` and the
/// shop queue's `myEntry`.
@freezed
abstract class QueueEntryDto with _$QueueEntryDto {
  const factory QueueEntryDto({
    @JsonKey(name: 'entryId') Object? entryId,
    @JsonKey(name: 'shopId') Object? shopId,
    @JsonKey(name: 'shopName') Object? shopName,
    @JsonKey(name: 'status') Object? status,
    @JsonKey(name: 'serviceId') Object? serviceId,
    @JsonKey(name: 'serviceName') Object? serviceName,
    @JsonKey(name: 'durationMin') Object? durationMin,
    @JsonKey(name: 'priceCents') Object? priceCents,
    @JsonKey(name: 'feeAmountCents') Object? feeAmountCents,
    @JsonKey(name: 'position') Object? position,
    @JsonKey(name: 'aheadCount') Object? aheadCount,
    @JsonKey(name: 'estimate') Object? estimate,
    @JsonKey(name: 'refundIfLeaving') Object? refundIfLeaving,
    @JsonKey(name: 'holdExpiresAt') Object? holdExpiresAt,
    @JsonKey(name: 'calledAt') Object? calledAt,
    @JsonKey(name: 'noShowFrom') Object? noShowFrom,
    @JsonKey(name: 'refunded') Object? refunded,
  }) = _QueueEntryDto;

  const QueueEntryDto._();

  factory QueueEntryDto.fromJson(Map<String, dynamic> json) =>
      _$QueueEntryDtoFromJson(json);

  /// Null without an id: an entry nothing can leave or refresh is no entry.
  QueueEntry? toDomain() {
    final id = asTextOrNull(entryId);
    if (id == null) return null;

    return QueueEntry(
      id: id,
      shopId: asText(shopId),
      shopName: asTextOrNull(shopName),
      status: QueueEntryStatus.fromWire(asTextOrNull(status)),
      serviceId: asText(serviceId),
      serviceName: asText(serviceName),
      durationMinutes: asInt(durationMin, 30),
      priceCents: asInt(priceCents),
      feeCents: asDoubleOrNull(feeAmountCents)?.round(),
      position: asDoubleOrNull(position)?.round(),
      aheadCount: asDoubleOrNull(aheadCount)?.round(),
      estimate: readWaitRange(estimate),
      // Absent is "no": promising a refund the server did not is the one
      // mistake on this screen that costs the customer money.
      refundIfLeaving: asBool(refundIfLeaving, fallback: false),
      holdExpiresAt: asInstantOrNull(holdExpiresAt),
      calledAt: asInstantOrNull(calledAt),
      noShowFrom: asInstantOrNull(noShowFrom),
      refunded: asBool(refunded, fallback: false),
    );
  }
}

/// Reads an entry from any map-shaped value, or null.
QueueEntry? readQueueEntry(Object? json) =>
    json is Map ? QueueEntryDto.fromJson(asMap(json)).toDomain() : null;

/// `GET /v1/shops/{shopId}/queue`.
@freezed
abstract class ShopQueueDto with _$ShopQueueDto {
  const factory ShopQueueDto({
    @JsonKey(name: 'shopId') Object? shopId,
    @JsonKey(name: 'state') Object? state,
    @JsonKey(name: 'notAccepting') Object? notAccepting,
    @JsonKey(name: 'waitingCount') Object? waitingCount,
    @JsonKey(name: 'inChair') Object? inChair,
    @JsonKey(name: 'estimate') Object? estimate,
    @JsonKey(name: 'feeAmountCents') Object? feeAmountCents,
    @JsonKey(name: 'myEntry') Object? myEntry,
  }) = _ShopQueueDto;

  const ShopQueueDto._();

  factory ShopQueueDto.fromJson(Map<String, dynamic> json) =>
      _$ShopQueueDtoFromJson(json);

  ShopQueue toDomain() => ShopQueue(
    shopId: asText(shopId),
    state: QueueState.fromWire(asTextOrNull(state)),
    closedReason: QueueClosedReason.fromWire(asTextOrNull(notAccepting)),
    waitingCount: asInt(waitingCount),
    inChair: asBool(inChair, fallback: false),
    estimate: readWaitRange(estimate) ?? const WaitRange(fromMin: 0, toMin: 0),
    feeCents: asInt(feeAmountCents),
    myEntry: readQueueEntry(myEntry),
  );
}

/// `POST /v1/shops/{shopId}/queue`.
@freezed
abstract class QueueJoinDto with _$QueueJoinDto {
  const factory QueueJoinDto({
    @JsonKey(name: 'entry') Object? entry,
    @JsonKey(name: 'clientSecret') Object? clientSecret,
    @JsonKey(name: 'holdExpiresAt') Object? holdExpiresAt,
    @JsonKey(name: 'feeAmountCents') Object? feeAmountCents,
    @JsonKey(name: 'estimate') Object? estimate,
  }) = _QueueJoinDto;

  const QueueJoinDto._();

  factory QueueJoinDto.fromJson(Map<String, dynamic> json) =>
      _$QueueJoinDtoFromJson(json);

  /// Null unless the place is usable: a fee needs a secret to pay it with,
  /// and a free place has none (providers §12).
  QueueJoin? toDomain() {
    final pending = readQueueEntry(entry);
    final secret = asTextOrNull(clientSecret);
    if (pending == null) return null;

    final fee = asInt(feeAmountCents, pending.feeCents ?? 0);
    if (secret == null && fee != 0) return null;

    return QueueJoin(
      entry: pending,
      clientSecret: secret ?? '',
      holdExpiresAt:
          asInstantOrNull(holdExpiresAt) ??
          pending.holdExpiresAt ??
          DateTime.now().toUtc().add(const Duration(minutes: 10)),
      feeCents: asInt(feeAmountCents, pending.feeCents ?? 0),
      estimate:
          readWaitRange(estimate) ??
          pending.estimate ??
          const WaitRange(fromMin: 0, toMin: 0),
    );
  }
}

/// One person in the owner's line.
@freezed
abstract class OwnerQueueEntryDto with _$OwnerQueueEntryDto {
  const factory OwnerQueueEntryDto({
    @JsonKey(name: 'entryId') Object? entryId,
    @JsonKey(name: 'status') Object? status,
    @JsonKey(name: 'kind') Object? kind,
    @JsonKey(name: 'customerName') Object? customerName,
    @JsonKey(name: 'serviceId') Object? serviceId,
    @JsonKey(name: 'serviceName') Object? serviceName,
    @JsonKey(name: 'durationMin') Object? durationMin,
    @JsonKey(name: 'joinedAt') Object? joinedAt,
    @JsonKey(name: 'calledAt') Object? calledAt,
    @JsonKey(name: 'startedAt') Object? startedAt,
    @JsonKey(name: 'noShowFrom') Object? noShowFrom,
    @JsonKey(name: 'requestedProviderId') Object? requestedProviderId,
    @JsonKey(name: 'providerId') Object? providerId,
    @JsonKey(name: 'providerName') Object? providerName,
  }) = _OwnerQueueEntryDto;

  const OwnerQueueEntryDto._();

  factory OwnerQueueEntryDto.fromJson(Map<String, dynamic> json) =>
      _$OwnerQueueEntryDtoFromJson(json);

  OwnerQueueEntry? toDomain() {
    final id = asTextOrNull(entryId);
    if (id == null) return null;

    return OwnerQueueEntry(
      id: id,
      status: QueueEntryStatus.fromWire(asTextOrNull(status)),
      kind: QueueEntryKind.fromWire(asTextOrNull(kind)),
      customerName: asTextOrNull(customerName),
      serviceId: asText(serviceId),
      serviceName: asText(serviceName),
      durationMinutes: asInt(durationMin, 30),
      joinedAt: asInstantOrNull(joinedAt),
      calledAt: asInstantOrNull(calledAt),
      startedAt: asInstantOrNull(startedAt),
      noShowFrom: asInstantOrNull(noShowFrom),
      requestedProviderId: asTextOrNull(requestedProviderId),
      providerId: asTextOrNull(providerId),
      providerName: asTextOrNull(providerName),
    );
  }
}

/// `GET /v1/shops/me/queue`, and the body of every owner action.
@freezed
abstract class OwnerQueueDto with _$OwnerQueueDto {
  const factory OwnerQueueDto({
    @JsonKey(name: 'localDate') Object? localDate,
    @JsonKey(name: 'state') Object? state,
    @JsonKey(name: 'waitingCount') Object? waitingCount,
    @JsonKey(name: 'emptiesAt') Object? emptiesAt,
    @JsonKey(name: 'entries') List<dynamic>? entries,
    @JsonKey(name: 'providers') List<dynamic>? providers,
  }) = _OwnerQueueDto;

  const OwnerQueueDto._();

  factory OwnerQueueDto.fromJson(Map<String, dynamic> json) =>
      _$OwnerQueueDtoFromJson(json);

  /// One unreadable row is dropped rather than failing the whole line: the
  /// barber still needs to call the people the app can read.
  OwnerQueue toDomain() => OwnerQueue(
    localDate: asText(localDate),
    state: QueueState.fromWire(asTextOrNull(state)),
    waitingCount: asInt(waitingCount),
    emptiesAt: asInstantOrNull(emptiesAt),
    entries: [
      for (final row in entries?.whereType<Map>() ?? const <Map>[])
        ?OwnerQueueEntryDto.fromJson(asMap(row)).toDomain(),
    ],
    providers: [
      for (final row in providers?.whereType<Map>() ?? const <Map>[])
        if (asTextOrNull(row['providerId']) case final id?)
          OwnerQueueProvider(
            id: id,
            name: asTextOrNull(row['name']),
            servingEntryId: asTextOrNull(row['servingEntryId']),
            calledEntryId: asTextOrNull(row['calledEntryId']),
            nextEntryId: asTextOrNull(row['nextEntryId']),
          ),
    ],
  );
}
