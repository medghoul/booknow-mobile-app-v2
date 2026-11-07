import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';
import 'package:booknow_mobile/features/bookings/cubit/bookings_cubit.dart';
import 'package:booknow_mobile/features/bookings/repositories/api_booking_repository.dart';
import 'package:booknow_mobile/features/queue/cubit/next_booking_cubit.dart';
import 'package:get_it/get_it.dart';

/// The customer's bookings feature.
void registerBookingsFeature(GetIt di) {
  di.registerLazySingleton<BookingRepository>(
    () => ApiBookingRepository(di<DioClient>()),
  );
  di.registerFactory(() => BookingsCubit(di<BookingRepository>()));
  di.registerLazySingleton(() => NextBookingCubit(di<BookingRepository>()));
}
