import 'package:ambuhub/core/network/dio_client.dart';
import 'package:ambuhub/features/auth/data/data_source/remote/auth_api_service.dart';
import 'package:ambuhub/features/auth/data/repository/repo_Implementation.dart';
import 'package:ambuhub/features/auth/domain/repository/repository.dart';
import 'package:ambuhub/features/auth/domain/usecases/login.dart';
import 'package:ambuhub/features/auth/domain/usecases/reset_password.dart';
import 'package:ambuhub/features/auth/domain/usecases/sign_up.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/cart/data/data_source/remote/cart_api_service.dart';
import 'package:ambuhub/features/cart/data/repository/cart_rep_implementation.dart';
import 'package:ambuhub/features/cart/domain/repository/cart_repo.dart';
import 'package:ambuhub/features/cart/domain/usecases/add_to_cart.dart';
import 'package:ambuhub/features/cart/domain/usecases/change_cart_item_quantity.dart';
import 'package:ambuhub/features/cart/domain/usecases/get_cart.dart';
import 'package:ambuhub/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/hire/data/repository/hire_repo_implementation.dart';
import 'package:ambuhub/features/hire/domain/repository/hire_repo.dart';
import 'package:ambuhub/features/hire/domain/usecases/place_hire.dart';
import 'package:ambuhub/features/hire/presentation/bloc/hire/hire_bloc.dart';
import 'package:ambuhub/features/order/data/data_source/remote/order_api_service.dart';
import 'package:ambuhub/features/services/data/data_source/service_api_service.dart';
import 'package:ambuhub/features/services/data/repository/service_repo_implementation.dart';
import 'package:ambuhub/features/services/domain/repository/service_repo.dart';
import 'package:ambuhub/features/services/domain/usecase/add_service.dart';
import 'package:ambuhub/features/services/domain/usecase/get_marketplace_services.dart';
import 'package:ambuhub/features/services/domain/usecase/get_provider_services.dart';
import 'package:ambuhub/features/services/domain/usecase/get_service_categories.dart';
import 'package:ambuhub/features/services/domain/usecase/update_service.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service/update_service_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> dependeciesInjection() async {
  sl.registerLazySingleton<Dio>(() => DioClient().dio);
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService(sl()));
  sl.registerLazySingleton<ServiceApiService>(() => ServiceApiService(sl()));
  sl.registerLazySingleton<CartApiService>(() => CartApiService(sl()));
  sl.registerLazySingleton<OrderApiService>(() => OrderApiService(sl()));

  // repo
  sl.registerLazySingleton<AuthRepository>(() => AuthRepoImplementation(sl()));
  sl.registerLazySingleton<ServiceRepo>(() => ServiceRepoImplementation(sl()));
  sl.registerLazySingleton<CartRepo>(() => CartRepoImplementation(sl()));
  sl.registerLazySingleton<HireRepo>(() => HireRepoImplementation(sl()));

  // usecases
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
  sl.registerLazySingleton<ClientSignUpUsecase>(
    () => ClientSignUpUsecase(sl()),
  );
  sl.registerLazySingleton<ServiceProviderSignUpUsecase>(
    () => ServiceProviderSignUpUsecase(sl()),
  );
  sl.registerLazySingleton<GetProviderServicesUsecase>(
    () => GetProviderServicesUsecase(sl()),
  );
  sl.registerLazySingleton<AddServiceUsecase>(() => AddServiceUsecase(sl()));
  sl.registerLazySingleton<GetMarketplaceServicesUsecase>(
    () => GetMarketplaceServicesUsecase(sl()),
  );
  sl.registerLazySingleton<UpdateServiceUsecase>(
    () => UpdateServiceUsecase(sl()),
  );
  sl.registerLazySingleton<ResetPasswordUsecase>(() => ResetPasswordUsecase(sl()));
  sl.registerLazySingleton<GetCartUsecase>(() => GetCartUsecase(sl()));
  sl.registerLazySingleton<AddToCartUsecase>(() => AddToCartUsecase(sl()));
  sl.registerLazySingleton<RemoveFromCartUsecase>(
    () => RemoveFromCartUsecase(sl()),
  );
  sl.registerLazySingleton<ChangeCartItemQuantityUsecase>(
    () => ChangeCartItemQuantityUsecase(sl()),
  );
  sl.registerLazySingleton<GetServiceCategoriesUsecase>(
    () => GetServiceCategoriesUsecase(sl()),
  );
  sl.registerLazySingleton<PlaceHireUsecase>(() => PlaceHireUsecase(sl()));

  // blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<GetProviderServicesBloc>(
    () => GetProviderServicesBloc(sl()),
  );
  sl.registerFactory<AddServiceBloc>(() => AddServiceBloc(sl()));
  sl.registerFactory<UpdateServiceBloc>(() => UpdateServiceBloc(sl()));
  sl.registerFactory<GetMarketplaceServicesBloc>(
    () => GetMarketplaceServicesBloc(sl()),
  );
  sl.registerFactory<CartBloc>(() => CartBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<GetServiceCategoriesBloc>(
    () => GetServiceCategoriesBloc(sl()),
  );
  sl.registerFactory<HireBloc>(() => HireBloc(sl()));
}
