import 'package:ambuhub/config/app_theme.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/app_route_observer.dart';
import 'package:ambuhub/dependencies_injection.dart';
import 'package:ambuhub/features/auth/domain/entities/client.dart';
import 'package:ambuhub/features/auth/domain/entities/service_provider.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:ambuhub/features/client_notification/presentation/bloc/client_notifications_bloc.dart';
import 'package:ambuhub/features/client_notification/presentation/bloc/client_notifications_event.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_event.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_bloc.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_event.dart';
import 'package:ambuhub/features/reviews/presentation/bloc/review/review_bloc.dart';
import 'package:ambuhub/features/reviews/presentation/bloc/review/review_event.dart';
import 'package:ambuhub/features/provider_notifications/presentation/bloc/provider_notifications_bloc.dart';
import 'package:ambuhub/features/provider_notifications/presentation/bloc/provider_notifications_event.dart';
import 'package:ambuhub/features/provider_dashboard/presentation/bloc/provider_dashboard_bloc.dart';
import 'package:ambuhub/features/provider_dashboard/presentation/bloc/provider_dashboard_event.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/onboarding/presentation/blocs/conectivity_event.dart';
import 'package:ambuhub/features/onboarding/presentation/blocs/connectivity_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service/update_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service_availability/update_service_availability_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';

// TODO 1: and number if needed
// TODO 1: make dashboard persistis use token is token is the active kjkjk;
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initializeDateFormatting('en');
  await dependeciesInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _precached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_precached) {
      _precached = true;
      Future.wait([
        precacheImage(const AssetImage('assets/images/logo.png'), context),
        precacheImage(
          const AssetImage('assets/images/equipment.webp'),
          context,
        ),
        precacheImage(
          const AssetImage('assets/images/personnel.webp'),
          context,
        ),
        precacheImage(
          const AssetImage('assets/images/transport.webp'),
          context,
        ),
        precacheImage(
          const AssetImage('assets/images/servicing.webp'),
          context,
        ),
      ]).then((value) {
        FlutterNativeSplash.remove();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(360, 800),
      ensureScreenSize: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: ((context) => sl<AuthBloc>())),
          BlocProvider<NavigationCubit>(
            create: ((context) => NavigationCubit()),
          ),
          BlocProvider<GetProviderServicesBloc>(
            create: ((context) => sl<GetProviderServicesBloc>()),
          ),
          BlocProvider<AddServiceBloc>(
            create: ((context) => sl<AddServiceBloc>()),
          ),
          BlocProvider<GetMarketplaceServicesBloc>(
            create: ((context) =>
                sl<GetMarketplaceServicesBloc>())
          ),
          BlocProvider<UpdateServiceBloc>(
            create: ((context) => sl<UpdateServiceBloc>()),
          ),
          BlocProvider<UpdateServiceAvailabilityBloc>(
            create: ((context) => sl<UpdateServiceAvailabilityBloc>()),
          ),
          BlocProvider(
            create: (_) =>
                ConnectivityBloc()..add(ConnectivityStartMonitoring()),
          ),
          BlocProvider<CartBloc>(create: ((context) => sl<CartBloc>()..add( const GetCart()))),
          BlocProvider<FavoriteBloc>(
            create: ((context) => sl<FavoriteBloc>()),
          ),
          BlocProvider<OrderBloc>(create: ((context) => sl<OrderBloc>()..add(const GetOrders())),),
          BlocProvider<ReviewBloc>(
            create: ((context) => sl<ReviewBloc>()),
          ),
          BlocProvider<GetServiceCategoriesBloc>(create: ((context) => sl<GetServiceCategoriesBloc>()..add(const GetServiceCategories()))),
          BlocProvider<ClientNotificationsBloc>(
            create: ((context) => sl<ClientNotificationsBloc>()),
          ),
          BlocProvider<ProviderNotificationsBloc>(
            create: ((context) => sl<ProviderNotificationsBloc>()),
          ),
          BlocProvider<ProviderDashboardBloc>(
            create: ((context) => sl<ProviderDashboardBloc>()),
          ),
        ],
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            final favorites = context.read<FavoriteBloc>();
            final reviews = context.read<ReviewBloc>();
            if (state is AuthSuccess) {
              favorites.add(const GetFavorites());
              reviews
                ..add(const GetAwaitingReviews())
                ..add(const GetWrittenReviews());
              if (state.data is ClientEntity) {
                context.read<ClientNotificationsBloc>()
                  ..add(const GetClientNotifications())
                  ..add(const GetClientUnreadNotificationCount());
              } else if (state.data is ServiceProviderEntity) {
                context.read<ProviderNotificationsBloc>()
                  ..add(const GetProviderNotifications())
                  ..add(const GetProviderUnreadNotificationCount());
                context.read<ProviderDashboardBloc>().add(
                      const LoadProviderDashboard(),
                    );
              }
            } else if (state is AuthInitial) {
              favorites.add(const FavoriteReset());
              reviews.add(const ReviewReset());
              context.read<ClientNotificationsBloc>().add(
                    const ClientNotificationsReset(),
                  );
              context.read<ProviderNotificationsBloc>().add(
                    const ProviderNotificationsReset(),
                  );
              context.read<ProviderDashboardBloc>().add(
                    const ProviderDashboardReset(),
                  );
            }
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.themeData,
            initialRoute: AppRoutes.splashScreen,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            navigatorObservers: [appRouteObserver],
          ),
        ),
      ),
    );
  }
}
