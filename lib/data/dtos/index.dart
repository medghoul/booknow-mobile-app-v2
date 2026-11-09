// `coercion.dart` is deliberately absent: `asText` and friends are for writing
// a `toDomain`, not for using one, and exporting them would put them in the
// namespace of every file that only wants a DTO.
export 'agenda_dto.dart';
export 'availability_dto.dart';
export 'booking_dto.dart';
export 'chairs_dto.dart';
export 'home_dto.dart';
export 'notification_preferences_dto.dart';
export 'parsing.dart';
export 'photo_upload_dto.dart';
export 'place_suggestion_dto.dart';
export 'queue_dto.dart';
export 'shop_dto.dart';
export 'shop_requests.dart';
export 'statistics_dto.dart';
export 'user_profile_dto.dart';
