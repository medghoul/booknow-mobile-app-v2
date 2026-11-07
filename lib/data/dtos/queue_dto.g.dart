// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QueueEntryDto _$QueueEntryDtoFromJson(Map<String, dynamic> json) =>
    _QueueEntryDto(
      entryId: json['entryId'],
      shopId: json['shopId'],
      shopName: json['shopName'],
      status: json['status'],
      serviceId: json['serviceId'],
      serviceName: json['serviceName'],
      durationMin: json['durationMin'],
      priceCents: json['priceCents'],
      feeAmountCents: json['feeAmountCents'],
      position: json['position'],
      aheadCount: json['aheadCount'],
      estimate: json['estimate'],
      refundIfLeaving: json['refundIfLeaving'],
      holdExpiresAt: json['holdExpiresAt'],
      calledAt: json['calledAt'],
      noShowFrom: json['noShowFrom'],
      refunded: json['refunded'],
    );

Map<String, dynamic> _$QueueEntryDtoToJson(_QueueEntryDto instance) =>
    <String, dynamic>{
      'entryId': ?instance.entryId,
      'shopId': ?instance.shopId,
      'shopName': ?instance.shopName,
      'status': ?instance.status,
      'serviceId': ?instance.serviceId,
      'serviceName': ?instance.serviceName,
      'durationMin': ?instance.durationMin,
      'priceCents': ?instance.priceCents,
      'feeAmountCents': ?instance.feeAmountCents,
      'position': ?instance.position,
      'aheadCount': ?instance.aheadCount,
      'estimate': ?instance.estimate,
      'refundIfLeaving': ?instance.refundIfLeaving,
      'holdExpiresAt': ?instance.holdExpiresAt,
      'calledAt': ?instance.calledAt,
      'noShowFrom': ?instance.noShowFrom,
      'refunded': ?instance.refunded,
    };

_ShopQueueDto _$ShopQueueDtoFromJson(Map<String, dynamic> json) =>
    _ShopQueueDto(
      shopId: json['shopId'],
      state: json['state'],
      notAccepting: json['notAccepting'],
      waitingCount: json['waitingCount'],
      inChair: json['inChair'],
      estimate: json['estimate'],
      feeAmountCents: json['feeAmountCents'],
      myEntry: json['myEntry'],
    );

Map<String, dynamic> _$ShopQueueDtoToJson(_ShopQueueDto instance) =>
    <String, dynamic>{
      'shopId': ?instance.shopId,
      'state': ?instance.state,
      'notAccepting': ?instance.notAccepting,
      'waitingCount': ?instance.waitingCount,
      'inChair': ?instance.inChair,
      'estimate': ?instance.estimate,
      'feeAmountCents': ?instance.feeAmountCents,
      'myEntry': ?instance.myEntry,
    };

_QueueJoinDto _$QueueJoinDtoFromJson(Map<String, dynamic> json) =>
    _QueueJoinDto(
      entry: json['entry'],
      clientSecret: json['clientSecret'],
      holdExpiresAt: json['holdExpiresAt'],
      feeAmountCents: json['feeAmountCents'],
      estimate: json['estimate'],
    );

Map<String, dynamic> _$QueueJoinDtoToJson(_QueueJoinDto instance) =>
    <String, dynamic>{
      'entry': ?instance.entry,
      'clientSecret': ?instance.clientSecret,
      'holdExpiresAt': ?instance.holdExpiresAt,
      'feeAmountCents': ?instance.feeAmountCents,
      'estimate': ?instance.estimate,
    };

_OwnerQueueEntryDto _$OwnerQueueEntryDtoFromJson(Map<String, dynamic> json) =>
    _OwnerQueueEntryDto(
      entryId: json['entryId'],
      status: json['status'],
      kind: json['kind'],
      customerName: json['customerName'],
      serviceId: json['serviceId'],
      serviceName: json['serviceName'],
      durationMin: json['durationMin'],
      joinedAt: json['joinedAt'],
      calledAt: json['calledAt'],
      startedAt: json['startedAt'],
      noShowFrom: json['noShowFrom'],
      requestedProviderId: json['requestedProviderId'],
      providerId: json['providerId'],
      providerName: json['providerName'],
    );

Map<String, dynamic> _$OwnerQueueEntryDtoToJson(_OwnerQueueEntryDto instance) =>
    <String, dynamic>{
      'entryId': ?instance.entryId,
      'status': ?instance.status,
      'kind': ?instance.kind,
      'customerName': ?instance.customerName,
      'serviceId': ?instance.serviceId,
      'serviceName': ?instance.serviceName,
      'durationMin': ?instance.durationMin,
      'joinedAt': ?instance.joinedAt,
      'calledAt': ?instance.calledAt,
      'startedAt': ?instance.startedAt,
      'noShowFrom': ?instance.noShowFrom,
      'requestedProviderId': ?instance.requestedProviderId,
      'providerId': ?instance.providerId,
      'providerName': ?instance.providerName,
    };

_OwnerQueueDto _$OwnerQueueDtoFromJson(Map<String, dynamic> json) =>
    _OwnerQueueDto(
      localDate: json['localDate'],
      state: json['state'],
      waitingCount: json['waitingCount'],
      emptiesAt: json['emptiesAt'],
      entries: json['entries'] as List<dynamic>?,
      providers: json['providers'] as List<dynamic>?,
    );

Map<String, dynamic> _$OwnerQueueDtoToJson(_OwnerQueueDto instance) =>
    <String, dynamic>{
      'localDate': ?instance.localDate,
      'state': ?instance.state,
      'waitingCount': ?instance.waitingCount,
      'emptiesAt': ?instance.emptiesAt,
      'entries': ?instance.entries,
      'providers': ?instance.providers,
    };
