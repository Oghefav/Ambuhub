import 'package:ambuhub/core/network/dio_client.dart';

import 'package:ambuhub/features/auth/data/data_source/remote/auth_api_service.dart';

import 'package:ambuhub/features/auth/data/repository/repo_Implementation.dart';

import 'package:ambuhub/features/auth/domain/repository/repository.dart';

import 'package:ambuhub/features/auth/domain/usecases/change_password.dart';
import 'package:ambuhub/features/auth/domain/usecases/login.dart';

import 'package:ambuhub/features/auth/domain/usecases/reset_password.dart';

import 'package:ambuhub/features/auth/domain/usecases/sign_up.dart';
import 'package:ambuhub/features/auth/domain/usecases/update_profile.dart';
import 'package:ambuhub/features/auth/domain/usecases/update_provider_profile.dart';

import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';

import 'package:ambuhub/features/booking/data/data_source/remote/booking_api_service.dart';
import 'package:ambuhub/features/booking/data/repository/booking_repo_implementation.dart';
import 'package:ambuhub/features/booking/domain/repository/booking_repo.dart';
import 'package:ambuhub/features/booking/domain/usecases/booking_checkout.dart';
import 'package:ambuhub/features/booking/domain/usecases/get_provider_hire_bookings.dart';
import 'package:ambuhub/features/booking/presentation/bloc/booking/booking_bloc.dart';
import 'package:ambuhub/features/cart/data/data_source/remote/cart_api_service.dart';

import 'package:ambuhub/features/cart/data/repository/cart_rep_implementation.dart';

import 'package:ambuhub/features/cart/domain/repository/cart_repo.dart';

import 'package:ambuhub/features/cart/domain/usecases/add_to_cart.dart';

import 'package:ambuhub/features/cart/domain/usecases/cart_checkout.dart';

import 'package:ambuhub/features/cart/domain/usecases/change_cart_item_quantity.dart';

import 'package:ambuhub/features/cart/domain/usecases/get_cart.dart';

import 'package:ambuhub/features/cart/domain/usecases/remove_from_cart.dart';

import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';

import 'package:ambuhub/features/favorite/data/data_source/remote/favorites_api_service.dart';

import 'package:ambuhub/features/favorite/data/repository/favorite_repo_implementation.dart';

import 'package:ambuhub/features/favorite/domain/repository/favorite_repo.dart';

import 'package:ambuhub/features/favorite/domain/usecases/add_favorite.dart';

import 'package:ambuhub/features/favorite/domain/usecases/get_favorites.dart';

import 'package:ambuhub/features/favorite/domain/usecases/remove_favorite.dart';

import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_bloc.dart';

import 'package:ambuhub/features/hire/domain/usecases/hire_checkout.dart';

import 'package:ambuhub/features/order/data/data_source/remote/order_api_service.dart';

import 'package:ambuhub/features/order/data/repository/order_repo_implementation.dart';

import 'package:ambuhub/features/order/domain/repository/order_repo.dart';

import 'package:ambuhub/features/order/domain/usecases/get_order_by_id.dart';

import 'package:ambuhub/features/order/domain/usecases/get_orders.dart';

import 'package:ambuhub/features/client_notification/data/data_source/remote/client_notifications_api_service.dart';
import 'package:ambuhub/features/client_notification/data/repository/client_notifications_repo_implementation.dart';
import 'package:ambuhub/features/client_notification/domain/repository/client_notifications_repo.dart';
import 'package:ambuhub/features/client_notification/domain/usecases/get_client_notifications.dart';
import 'package:ambuhub/features/client_notification/domain/usecases/get_client_unread_notification_count.dart';
import 'package:ambuhub/features/client_notification/domain/usecases/mark_all_client_notifications_read.dart';
import 'package:ambuhub/features/client_notification/domain/usecases/mark_client_notification_read.dart';
import 'package:ambuhub/features/client_notification/presentation/bloc/client_notifications_bloc.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_bloc.dart';
import 'package:ambuhub/features/provider_notifications/data/data_source/remote/provider_notifications_api_service.dart';
import 'package:ambuhub/features/provider_notifications/data/repository/provider_notifications_repo_implementation.dart';
import 'package:ambuhub/features/provider_notifications/domain/repository/provider_notifications_repo.dart';
import 'package:ambuhub/features/provider_notifications/domain/usecases/get_provider_notifications.dart';
import 'package:ambuhub/features/provider_notifications/domain/usecases/get_provider_unread_notification_count.dart';
import 'package:ambuhub/features/provider_notifications/domain/usecases/mark_all_provider_notifications_read.dart';
import 'package:ambuhub/features/provider_notifications/domain/usecases/mark_provider_notification_read.dart';
import 'package:ambuhub/features/provider_notifications/presentation/bloc/provider_notifications_bloc.dart';
import 'package:ambuhub/features/provider_dashboard/data/data_source/remote/provider_dashboard_api_service.dart';
import 'package:ambuhub/features/provider_dashboard/data/repository/provider_dashboard_repo_implementation.dart';
import 'package:ambuhub/features/provider_dashboard/domain/repository/provider_dashboard_repository.dart';
import 'package:ambuhub/features/provider_dashboard/domain/usecases/get_provider_sales_by_month.dart';
import 'package:ambuhub/features/provider_dashboard/domain/usecases/get_provider_wallet.dart';
import 'package:ambuhub/features/provider_dashboard/presentation/bloc/provider_dashboard_bloc.dart';

import 'package:ambuhub/features/reviews/data/data_source/remote/reviews_api_service.dart';

import 'package:ambuhub/features/reviews/data/repository/review_repo_implementation.dart';

import 'package:ambuhub/features/reviews/domain/repository/review_repo.dart';

import 'package:ambuhub/features/reviews/domain/usecases/get_awaiting_reviews.dart';

import 'package:ambuhub/features/reviews/domain/usecases/get_review_by_id.dart';

import 'package:ambuhub/features/reviews/domain/usecases/get_service_reviews.dart';
import 'package:ambuhub/features/reviews/domain/usecases/get_written_reviews.dart';
import 'package:ambuhub/features/reviews/presentation/bloc/service_reviews/service_reviews_bloc.dart';

import 'package:ambuhub/features/reviews/domain/usecases/write_review.dart';

import 'package:ambuhub/features/reviews/presentation/bloc/review/review_bloc.dart';

import 'package:ambuhub/features/services/data/data_source/service_api_service.dart';

import 'package:ambuhub/features/services/data/repository/service_repo_implementation.dart';

import 'package:ambuhub/features/services/domain/repository/service_repo.dart';

import 'package:ambuhub/features/services/domain/usecase/add_service.dart';

import 'package:ambuhub/features/services/domain/usecase/get_marketplace_service_by_id.dart';
import 'package:ambuhub/features/services/domain/usecase/get_marketplace_services.dart';

import 'package:ambuhub/features/services/domain/usecase/get_provider_services.dart';

import 'package:ambuhub/features/services/domain/usecase/get_service_categories.dart';

import 'package:ambuhub/features/services/domain/usecase/delete_service.dart';
import 'package:ambuhub/features/services/domain/usecase/update_service.dart';
import 'package:ambuhub/features/services/domain/usecase/update_service_availability.dart';
import 'package:ambuhub/features/services/presentation/bloc/delete_service/delete_service_bloc.dart';

import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_bloc.dart';

import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/marketplace_service_detail/marketplace_service_detail_bloc.dart';

import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_bloc.dart';

import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_bloc.dart';

import 'package:ambuhub/features/services/presentation/bloc/update_service/update_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service_availability/update_service_availability_bloc.dart';

import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> dependeciesInjection() async {
  sl.registerLazySingleton<Dio>(() => DioClient().dio);

  sl.registerLazySingleton<AuthApiService>(() => AuthApiService(sl()));

  sl.registerLazySingleton<ServiceApiService>(() => ServiceApiService(sl()));

  sl.registerLazySingleton<CartApiService>(() => CartApiService(sl()));

  sl.registerLazySingleton<OrderApiService>(() => OrderApiService(sl()));

  sl.registerLazySingleton<FavoritesApiService>(
    () => FavoritesApiService(sl()),
  );

  sl.registerLazySingleton<ReviewsApiService>(() => ReviewsApiService(sl()));

  sl.registerLazySingleton<ClientNotificationsApiService>(
    () => ClientNotificationsApiService(sl()),
  );

  sl.registerLazySingleton<ProviderNotificationsApiService>(
    () => ProviderNotificationsApiService(sl()),
  );

  sl.registerLazySingleton<BookingApiService>(() => BookingApiService(sl()));

  sl.registerLazySingleton<ProviderDashboardApiService>(
    () => ProviderDashboardApiService(sl()),
  );

  // repo

  sl.registerLazySingleton<AuthRepository>(() => AuthRepoImplementation(sl()));

  sl.registerLazySingleton<ServiceRepo>(() => ServiceRepoImplementation(sl()));

  sl.registerLazySingleton<CartRepo>(() => CartRepoImplementation(sl()));

  sl.registerLazySingleton<OrderRepo>(() => OrderRepoImplementation(sl()));

  sl.registerLazySingleton<FavoriteRepo>(
    () => FavoriteRepoImplementation(sl()),
  );

  sl.registerLazySingleton<ReviewRepo>(() => ReviewRepoImplementation(sl()));

  sl.registerLazySingleton<ClientNotificationsRepo>(
    () => ClientNotificationsRepoImplementation(sl()),
  );

  sl.registerLazySingleton<ProviderNotificationsRepo>(
    () => ProviderNotificationsRepoImplementation(sl()),
  );

  sl.registerLazySingleton<BookingRepo>(() => BookingRepoImplementation(sl()));

  sl.registerLazySingleton<ProviderDashboardRepository>(
    () => ProviderDashboardRepoImplementation(sl()),
  );

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

  sl.registerLazySingleton<GetMarketplaceServiceByIdUsecase>(
    () => GetMarketplaceServiceByIdUsecase(sl()),
  );

  sl.registerLazySingleton<UpdateServiceUsecase>(
    () => UpdateServiceUsecase(sl()),
  );

  sl.registerLazySingleton<DeleteServiceUsecase>(
    () => DeleteServiceUsecase(sl()),
  );

  sl.registerLazySingleton<UpdateServiceAvailabilityUsecase>(
    () => UpdateServiceAvailabilityUsecase(sl()),
  );

  sl.registerLazySingleton<ResetPasswordUsecase>(
    () => ResetPasswordUsecase(sl()),
  );

  sl.registerLazySingleton<UpdateProfileUsecase>(
    () => UpdateProfileUsecase(sl()),
  );

  sl.registerLazySingleton<UpdateProviderProfileUsecase>(
    () => UpdateProviderProfileUsecase(sl()),
  );

  sl.registerLazySingleton<ChangePasswordUsecase>(
    () => ChangePasswordUsecase(sl()),
  );

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

  sl.registerLazySingleton<GetOrdersUsecase>(() => GetOrdersUsecase(sl()));

  sl.registerLazySingleton<GetOrderByIdUsecase>(
    () => GetOrderByIdUsecase(sl()),
  );

  sl.registerLazySingleton<HireCheckoutUsecase>(
    () => HireCheckoutUsecase(sl()),
  );

  sl.registerLazySingleton<CartCheckoutUsecase>(
    () => CartCheckoutUsecase(sl()),
  );

  sl.registerLazySingleton<BookingCheckoutUsecase>(
    () => BookingCheckoutUsecase(sl()),
  );

  sl.registerLazySingleton<GetProviderHireBookingsUsecase>(
    () => GetProviderHireBookingsUsecase(sl()),
  );

  sl.registerLazySingleton<GetFavoritesUsecase>(
    () => GetFavoritesUsecase(sl()),
  );

  sl.registerLazySingleton<AddFavoriteUsecase>(() => AddFavoriteUsecase(sl()));

  sl.registerLazySingleton<RemoveFavoriteUsecase>(
    () => RemoveFavoriteUsecase(sl()),
  );

  sl.registerLazySingleton<GetAwaitingReviewsUsecase>(
    () => GetAwaitingReviewsUsecase(sl()),
  );

  sl.registerLazySingleton<GetWrittenReviewsUsecase>(
    () => GetWrittenReviewsUsecase(sl()),
  );

  sl.registerLazySingleton<WriteReviewUsecase>(() => WriteReviewUsecase(sl()));

  sl.registerLazySingleton<GetReviewByIdUsecase>(
    () => GetReviewByIdUsecase(sl()),
  );

  sl.registerLazySingleton<GetServiceReviewsUsecase>(
    () => GetServiceReviewsUsecase(sl()),
  );

  sl.registerLazySingleton<GetClientNotificationsUsecase>(
    () => GetClientNotificationsUsecase(sl()),
  );

  sl.registerLazySingleton<GetClientUnreadNotificationCountUsecase>(
    () => GetClientUnreadNotificationCountUsecase(sl()),
  );

  sl.registerLazySingleton<MarkClientNotificationReadUsecase>(
    () => MarkClientNotificationReadUsecase(sl()),
  );

  sl.registerLazySingleton<MarkAllClientNotificationsReadUsecase>(
    () => MarkAllClientNotificationsReadUsecase(sl()),
  );

  sl.registerLazySingleton<GetProviderNotificationsUsecase>(
    () => GetProviderNotificationsUsecase(sl()),
  );

  sl.registerLazySingleton<GetProviderUnreadNotificationCountUsecase>(
    () => GetProviderUnreadNotificationCountUsecase(sl()),
  );

  sl.registerLazySingleton<MarkProviderNotificationReadUsecase>(
    () => MarkProviderNotificationReadUsecase(sl()),
  );

  sl.registerLazySingleton<MarkAllProviderNotificationsReadUsecase>(
    () => MarkAllProviderNotificationsReadUsecase(sl()),
  );

  sl.registerLazySingleton<GetProviderWalletUsecase>(
    () => GetProviderWalletUsecase(sl()),
  );

  sl.registerLazySingleton<GetProviderSalesByMonthUsecase>(
    () => GetProviderSalesByMonthUsecase(sl()),
  );

  // blocs

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl()),
  );

  sl.registerFactory<GetProviderServicesBloc>(
    () => GetProviderServicesBloc(sl()),
  );

  sl.registerFactory<AddServiceBloc>(() => AddServiceBloc(sl()));

  sl.registerFactory<UpdateServiceBloc>(() => UpdateServiceBloc(sl()));

  sl.registerFactory<DeleteServiceBloc>(() => DeleteServiceBloc(sl()));

  sl.registerFactory<UpdateServiceAvailabilityBloc>(
    () => UpdateServiceAvailabilityBloc(sl()),
  );

  sl.registerFactory<GetMarketplaceServicesBloc>(
    () => GetMarketplaceServicesBloc(sl(), sl()),
  );

  sl.registerFactory<CartBloc>(() => CartBloc(sl(), sl(), sl(), sl()));

  sl.registerFactory<GetServiceCategoriesBloc>(
    () => GetServiceCategoriesBloc(sl()),
  );

  sl.registerFactory<OrderBloc>(() => OrderBloc(sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory<FavoriteBloc>(() => FavoriteBloc(sl(), sl(), sl()));

  sl.registerFactory<ReviewBloc>(() => ReviewBloc(sl(), sl(), sl(), sl()));

  sl.registerFactory<ServiceReviewsBloc>(() => ServiceReviewsBloc(sl()));

  sl.registerFactory<MarketplaceServiceDetailBloc>(
    () => MarketplaceServiceDetailBloc(sl(), sl()),
  );

  sl.registerFactory<ClientNotificationsBloc>(
    () => ClientNotificationsBloc(sl(), sl(), sl(), sl()),
  );

  sl.registerFactory<ProviderNotificationsBloc>(
    () => ProviderNotificationsBloc(sl(), sl(), sl(), sl()),
  );

  sl.registerFactory<BookingBloc>(() => BookingBloc(sl()));

  sl.registerFactory<ProviderDashboardBloc>(
    () => ProviderDashboardBloc(sl(), sl()),
  );
}
