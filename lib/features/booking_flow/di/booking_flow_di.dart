import 'package:booknow_mobile/core/services/payments/payment_service.dart';
import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/domain/repositories/shop_directory_repository.dart';
import 'package:booknow_mobile/features/booking_flow/repositories/api_shop_directory_repository.dart';
import 'package:get_it/get_it.dart';

/// The booking flow's own dependencies.
///
/// No cubit here: [BookingFlowCubit] takes the shop and the slot it was opened
/// with, so the page builds it rather than GetIt handing out one that would be
/// shared between two flows.
void registerBookingFlowFeature(GetIt di) {
  di.registerLazySingleton<ShopDirectoryRepository>(
    () => ApiShopDirectoryRepository(di<DioClient>()),
  );
  di.registerLazySingleton<PaymentService>(PaymentService.new);
}
