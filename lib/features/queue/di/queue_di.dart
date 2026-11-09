import 'package:booknow_mobile/domain/repositories/chairs_repository.dart';
import 'package:booknow_mobile/features/chairs/cubit/owner_chairs_cubit.dart';
import 'package:booknow_mobile/features/chairs/repositories/api_chairs_repository.dart';
import 'package:booknow_mobile/features/home_widgets/home_widget_sync.dart';
import 'package:booknow_mobile/features/queue/cubit/live_status_cubit.dart';
import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/queue/cubit/owner_queue_cubit.dart';
import 'package:booknow_mobile/features/queue/cubit/shop_mode_notifier.dart';
import 'package:booknow_mobile/features/queue/repositories/api_queue_repository.dart';
import 'package:get_it/get_it.dart';

/// Queue mode, for customers and owners alike.
void registerQueueFeature(GetIt di) {
  di.registerLazySingleton<LiveStatusCubit>(
    () => LiveStatusCubit(di<QueueRepository>()),
  );
  di.registerLazySingleton<HomeWidgetSync>(
    () => HomeWidgetSync(
      auth: di(),
      live: di(),
      bookings: di(),
      queue: di(),
      agenda: di(),
    ),
  );
  di.registerLazySingleton<QueueRepository>(
    () => ApiQueueRepository(di<DioClient>()),
  );
  di.registerLazySingleton<ShopModeNotifier>(ShopModeNotifier.new);
  di.registerFactory(
    () => OwnerQueueCubit(di<QueueRepository>(), di<ShopRepository>()),
  );
  di.registerLazySingleton<ChairsRepository>(
    () => ApiChairsRepository(di<DioClient>()),
  );
  di.registerFactory(
    () => OwnerChairsCubit(di<ChairsRepository>(), di<QueueRepository>()),
  );
}
