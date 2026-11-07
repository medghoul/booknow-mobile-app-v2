import '../../core/error/api_result.dart';
import '../models/customer_home.dart';

/// `GET /v1/home` — the whole customer home in one call.
abstract interface class CustomerHomeRepository {
  /// Coordinates are optional and never stored: without them the shops come
  /// back ordered by name instead of by distance.
  Future<ApiResult<CustomerHome>> load({double? lat, double? lng});
}
