import 'package:ambuhub/core/network/dio_client.dart';
import 'package:ambuhub/features/auth/data/data_source/remote/auth_api_service.dart';
import 'package:ambuhub/features/auth/data/repository/repo_Implementation.dart';
import 'package:ambuhub/features/auth/domain/repository/repository.dart';
import 'package:ambuhub/features/auth/domain/usecases/login.dart';
import 'package:ambuhub/features/auth/domain/usecases/sign_up.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/services/data/data_source/service_api_service.dart';
import 'package:ambuhub/features/services/data/repository/service_repo_implementation.dart';
import 'package:ambuhub/features/services/domain/repository/service_repo.dart';
import 'package:ambuhub/features/services/domain/usecase/add_service.dart';
import 'package:ambuhub/features/services/domain/usecase/get_services.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> dependeciesInjection() async {
  sl.registerLazySingleton<Dio>(() => DioClient().dio);
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService(sl()));
  sl.registerLazySingleton<ServiceApiService>(() => ServiceApiService(sl()));

  // repo
  sl.registerLazySingleton<AuthRepository>(() => AuthRepoImplementation(sl()));
  sl.registerLazySingleton<ServiceRepo>(() => ServiceRepoImplementation(sl()));

  // usecases
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
  sl.registerLazySingleton<SignUpUsecase>(() => SignUpUsecase(sl()));
  sl.registerLazySingleton<GetServicesUsecase>(() => GetServicesUsecase(sl()));
  sl.registerLazySingleton<AddServiceUsecase>(() => AddServiceUsecase(sl()));

  // blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
  sl.registerFactory<GetServicesBloc>(() => GetServicesBloc(sl()));
  sl.registerFactory<AddServiceBloc>(()=> AddServiceBloc(sl()));
}
