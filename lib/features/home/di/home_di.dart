import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/domain/repositories/customer_home_repository.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/home/cubit/customer_home_cubit.dart';
import 'package:booknow_mobile/features/home/repositories/api_customer_home_repository.dart';
import 'package:get_it/get_it.dart';

/// The customer's home feature.
void registerHomeFeature(GetIt di) {
  di.registerLazySingleton<CustomerHomeRepository>(
    () => ApiCustomerHomeRepository(di<DioClient>()),
  );
  di.registerFactory(
    () => CustomerHomeCubit(
      di<CustomerHomeRepository>(),
      queue: di<QueueRepository>(),
      isSignedIn: () => di<AuthCubit>().state.session != null,
    ),
  );
}
