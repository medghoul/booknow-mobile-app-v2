import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/shop_setup/repositories/api_shop_repository.dart';
import 'package:get_it/get_it.dart';

/// Registers the shop repository.
void registerShopFeature(GetIt di) {
  di.registerLazySingleton<ShopRepository>(
    () => ApiShopRepository(di<DioClient>()),
  );
}
