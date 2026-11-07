import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/data/entities/api_endpoints.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/customer_home_repository.dart';

/// The real home endpoint.
class ApiCustomerHomeRepository implements CustomerHomeRepository {
  const ApiCustomerHomeRepository(this._client);

  final DioClient _client;

  @override
  Future<ApiResult<CustomerHome>> load({double? lat, double? lng}) async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.home,
      // Both or neither: one coordinate on its own says nothing, and the
      // server answers the name-ordered list for anything it cannot use.
      queryParameters: lat != null && lng != null
          ? {'lat': lat, 'lng': lng}
          : null,
    );

    return result.parsed((json) => HomeDto.fromJson(json).toDomain());
  }
}
