import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/domain/repositories/agenda_repository.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_cubit.dart';
import 'package:booknow_mobile/features/agenda/repositories/api_agenda_repository.dart';
import 'package:get_it/get_it.dart';

/// Registers the agenda repository and its cubit.
void registerAgendaFeature(GetIt di) {
  di.registerLazySingleton<AgendaRepository>(
    () => ApiAgendaRepository(di<DioClient>()),
  );

  // A factory, not a singleton: the cubit holds a ticking timer and the day
  // being looked at, and both belong to one visit to the tab.
  di.registerFactory(() => OwnerAgendaCubit(di<AgendaRepository>()));
}
