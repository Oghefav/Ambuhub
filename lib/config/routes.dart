import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/ui/login/screen/login_screen.dart';
import 'package:ambuhub/features/auth/presentation/ui/reset_password/screen/reset_password.dart';
import 'package:ambuhub/features/auth/presentation/ui/role/screen/role_screen.dart';
import 'package:ambuhub/features/auth/presentation/ui/sign_up/screen/sign_up_screen.dart';
import 'package:ambuhub/features/availablity/presentation/ui/screens/availability_screen.dart';
import 'package:ambuhub/features/booking/presentation/ui/screen/booking_screen.dart';
import 'package:ambuhub/features/cart/presentation/ui/cart/screen/cart.dart';
import 'package:ambuhub/features/client_dashboard/presentation/ui/screens/client_dashboard.dart';
import 'package:ambuhub/features/client_notification/presentation/ui/screen/customer_notification_screen.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/screen/client_profile_screen.dart';
import 'package:ambuhub/features/favorite/presentation/ui/screen/favorite_screen.dart';
import 'package:ambuhub/features/hire/presentation/ui/screen/hire_checkout.dart';
import 'package:ambuhub/features/provider_notifications/presentation/ui/screen/provider_notifications_screen.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:ambuhub/features/order/presentation/ui/order_receipt_args.dart';
import 'package:ambuhub/features/order/presentation/ui/screen/order_receipt.dart';
import 'package:ambuhub/features/order/presentation/ui/screen/order_screen.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/ui/screens/provider_dash_board_screen.dart';
import 'package:ambuhub/features/onboarding/presentation/ui/onboarding/screen/onboarding_screen.dart';
import 'package:ambuhub/features/onboarding/presentation/ui/onboarding/screen/splash_screen.dart';
import 'package:ambuhub/features/provider_profile/presentation/ui/screen/provider_profile_screen.dart';
import 'package:ambuhub/features/referral/presentation/ui/screen/referrak_screen.dart';
import 'package:ambuhub/features/reviews/presentation/ui/screen/reviews_screen.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/screen/add_service_screen.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/screen/listings_screen.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/screens/market_screen.dart';
import 'package:ambuhub/features/services/presentation/bloc/marketplace_service_detail/marketplace_service_detail_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/marketplace_service_detail/marketplace_service_detail_event.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/service_detail/market_place_service_detail_args.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/service_detail/screen/service_detail.dart';
import 'package:ambuhub/features/services/presentation/ui/service_detail/service_detail_screen.dart';
import 'package:ambuhub/features/services/presentation/ui/category_info/screen/category_info_screen.dart';
import 'package:ambuhub/features/services/presentation/ui/update_service/update_service_screen.dart';
import 'package:ambuhub/features/setting/presentation/ui/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ambuhub/dependencies_injection.dart';

class AppRoutes {
  static const loginScreen = '/loginScreen';
  static const roleScreen = '/roleScreen';
  static const signUpScreen = '/signUpScreen';
  static const marketPlaceServiceDetailScreen = '/marketPlaceServiceDetailScreen';
  static const providerDashBoardScreen = '/providerDashBoardScreen';
  static const bookingScreen = '/bookingScreen';
  static const availabilityScreen = '/availabilityScreen';
  static const providerNotificationsScreen = '/providerNotificationsScreen';
  static const providerProfileScreen = '/providerProfileScreen';
  static const clientProfileScreen = '/clientProfileScreen';
  static const settingScreen = '/settingScreen';
  static const listingsScreen = '/listingsScreen';
  static const addServiceScreen = '/addServiceScreen';
  static const onboardingScreen = '/onboardingScreen';
  static const splashScreen = '/splashScreen';
  static const categoryInfoScreen = '/categoryInfoScreen';
  static const serviceDetailScreen = '/serviceDetailScreen';
  static const updateServiceScreen = '/updateServiceScreen';
  static const clientDashBoardScreen = '/clientDashBoardScreen';
  static const orderScreen = '/orderScreen';
  static const favoriteScreen = '/favoriteScreen';
  static const reviewsScreen = '/reviewsScreen';
  static const referralScreen = '/referralScreen';
  static const notificationScreen = '/notificationScreen';
  static const cartScreen = '/cartScreen';
  static const markerScreen = '/markerScreen';
  static const resetPasswordScreen = '/resetPasswordScreen';
  static const hireCheckoutScreen = '/hireCheckoutScreen';
  static const orderReceiptScreen = '/orderReceiptScreen';

  /// Fade into onboarding so the splash route stays visible underneath
  /// until the transition finishes (avoids a black frame).
  static Route<void> onboardingRoute() {
    return fadeRoute<void>(
      const OnboardingScreen(),
      settings: const RouteSettings(name: onboardingScreen),
    );
  }

  static Route<T> fadeRoute<T>(
    Widget page, {
    RouteSettings? settings,
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      opaque: true,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case roleScreen:
        return MaterialPageRoute(builder: (_) => const RoleScreen());
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case serviceDetailScreen:
        final service = settings.arguments as ServiceEntity;
        return MaterialPageRoute(
          builder: (_) => ServiceDetailScreen(service: service),
        );
      case onboardingScreen:
        return onboardingRoute();
      case signUpScreen:
        final role = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthBloc>(
            create: ((context) => sl<AuthBloc>()),
            child: SignUpScreen(role: role),
          ),
        );
      case cartScreen:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case clientProfileScreen:
        return MaterialPageRoute(builder: (_) => const ClientProfileScreen());
      case orderScreen:
        return MaterialPageRoute(builder: (_) => const OrderScreen());
      case favoriteScreen:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());
      case reviewsScreen:
        return MaterialPageRoute(builder: (_) => const ReviewsScreen());
      case referralScreen:
        return MaterialPageRoute(builder: (_) => const ReferralScreen());
      case clientDashBoardScreen:
        return MaterialPageRoute(builder: (_) => const ClientDashBoardScreen());
      case notificationScreen:
        return MaterialPageRoute(
          builder: (_) => const CustomerNotificationScreen(),
        );
      case addServiceScreen:
        return MaterialPageRoute(builder: (_) => const AddServiceScreen());
      case listingsScreen:
        return MaterialPageRoute(builder: (_) => const ListingsScreen());
      case settingScreen:
        return MaterialPageRoute(builder: (_) => const SettingScreen());
      case providerNotificationsScreen:
        return MaterialPageRoute(
          builder: (_) => const ProviderNotificationsScreen(),
        );
      case availabilityScreen:
        return MaterialPageRoute(builder: (_) => const AvailabilityScreen());
      case bookingScreen:
        return MaterialPageRoute(builder: (_) => const BookingScreen());
      case providerDashBoardScreen:
        return MaterialPageRoute(builder: (_) => ProviderDashBoardScreen());
      case categoryInfoScreen:
        final category = settings.arguments as ServiceCategoryEntity;
        return MaterialPageRoute(
          builder: (_) => CategoryInfoScreen(category: category),
        );

      case markerScreen:
        final category = settings.arguments as ServiceCategoryEntity;
        return MaterialPageRoute(
          builder: (_) => MarketplaceScreen(category: category),
        );
      case providerProfileScreen:
        return MaterialPageRoute(
          builder: (_) => const ProviderProfileScreen(),
        );
      case updateServiceScreen:
        final service = settings.arguments as ServiceEntity;
        return MaterialPageRoute(
          builder: (_) => UpdateServiceScreen(service: service),
        );
      case resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case hireCheckoutScreen:
        final service = settings.arguments as ServiceEntity;
        return MaterialPageRoute(
          builder: (_) => HireCheckoutScreen(service: service),
        );
      case orderReceiptScreen:
        final args = settings.arguments;
        final receiptArgs = args is OrderReceiptArgs
            ? args
            : OrderReceiptArgs.fromOrder(args as OrderEntity);
        return MaterialPageRoute(
          builder: (_) => OrderReceiptScreen(args: receiptArgs),
        );
      case marketPlaceServiceDetailScreen:
        final rawArgs = settings.arguments;
        final detailArgs = rawArgs is MarketPlaceServiceDetailArgs
            ? rawArgs
            : MarketPlaceServiceDetailArgs.fromService(
                rawArgs as ServiceEntity,
              );
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<MarketplaceServiceDetailBloc>()
              ..add(
                LoadMarketplaceServiceDetail(serviceId: detailArgs.serviceId),
              ),
            child: MarketPlaceServiceDetailScreen(
              backLabel: detailArgs.resolveBackLabel(
                service: rawArgs is ServiceEntity ? rawArgs : null,
              ),
            ),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
