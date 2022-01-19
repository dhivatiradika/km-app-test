import 'package:get_it/get_it.dart';
import 'package:km_app_test/data/datasources/user_remote_data_source.dart';
import 'package:km_app_test/data/repositories/user_repository_impl.dart';
import 'package:km_app_test/domain/repositories/user_repository.dart';
import 'package:km_app_test/domain/usecase/get_user.dart';
import 'package:km_app_test/presentation/provider/selected_user_notifier.dart';
import 'package:km_app_test/presentation/provider/user_list_notifier.dart';

import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  //provider
  locator.registerFactory(() => UserListNotifier(locator()));
  locator.registerFactory(() => SelectedUserNotifier());

  //use case
  locator.registerLazySingleton(() => GetUser(locator()));

  //repository
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: locator()));

  //data sources
  locator.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: locator()));

  //external
  locator.registerLazySingleton(() => http.Client());
}
