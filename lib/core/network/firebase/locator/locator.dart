import 'package:get_it/get_it.dart';


import '../repository/user_repository.dart';
import '../services/current_service.dart';
import '../services/dummy_service.dart';

final GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => CurrentService());
  locator.registerLazySingleton(() => DummyService());
  locator.registerLazySingleton(() => UserRepository());
  // locator.registerLazySingleton(() => FirestoreService());
}
