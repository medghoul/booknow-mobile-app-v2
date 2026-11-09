import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/domain/repositories/statistics_repository.dart';
import 'package:booknow_mobile/features/statistics/cubit/owner_statistics_cubit.dart';
import 'package:booknow_mobile/features/statistics/repositories/api_statistics_repository.dart';
import 'package:get_it/get_it.dart';

/// The owner's statistics.
void registerStatisticsFeature(GetIt di) {
  di.registerLazySingleton<StatisticsRepository>(
    () => ApiStatisticsRepository(di<DioClient>()),
  );
  di.registerFactory(() => OwnerStatisticsCubit(di<StatisticsRepository>()));
}
