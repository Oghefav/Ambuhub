import 'package:ambuhub/core/network/dio_client.dart';
import 'package:ambuhub/features/auth/data/data_source/remote/auth_api_service.dart';
import 'package:ambuhub/features/auth/data/repository/repo_Implementation.dart';
import 'package:ambuhub/features/auth/domain/repository/repository.dart';
import 'package:ambuhub/features/auth/domain/usecases/login.dart';
import 'package:ambuhub/features/auth/domain/usecases/sign_up.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> dependeciesInjection() async {
  sl.registerLazySingleton<Dio>(() => DioClient.createDio());
  sl.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl(sl()));

  // repo
  sl.registerLazySingleton<AuthRepository>(() => AuthRepoImplementation(sl()));

  // usecases
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
  sl.registerLazySingleton<SignUpUsecase>(() => SignUpUsecase(sl()));

  // blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
}
