import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/ui/login/screen/login_screen.dart';
import 'package:ambuhub/features/auth/presentation/ui/role/screen/role_screen.dart';
import 'package:ambuhub/features/auth/presentation/ui/sign_up/screen/sign_up_screen.dart';
import 'package:ambuhub/features/availablity/presentation/ui/screens/availability_screen.dart';
import 'package:ambuhub/features/booking/presentation/ui/screen/booking_screen.dart';
import 'package:ambuhub/features/cart/presentation/ui/cart/screen/cart.dart';
import 'package:ambuhub/features/client_dashboard/presentation/ui/screens/client_dashboard.dart';
import 'package:ambuhub/features/client_notification/presentation/ui/screen/customer_notification_screen.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/screen/client_profile_screen.dart';
import 'package:ambuhub/features/favorite/presentation/ui/screen/favorite_screen.dart';
import 'package:ambuhub/features/message/presentation/ui/screen/message_screen.dart';
import 'package:ambuhub/features/order/presentation/ui/screen/order_screen.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/ui/screens/provider_dash_board_screen.dart';
import 'package:ambuhub/features/onboarding/presentation/ui/onboarding/screen/onboarding_screen.dart';
import 'package:ambuhub/features/onboarding/presentation/ui/onboarding/screen/splash_screen.dart';
import 'package:ambuhub/features/provider_profile/presentation/ui/screen/profile_screen.dart';
import 'package:ambuhub/features/referral/presentation/ui/screen/referrak_screen.dart';
import 'package:ambuhub/features/reviews/presentation/ui/screen/reviews_screen.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/screen/add_service_screen.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/screen/listings_screen.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/screens/market_screen.dart';
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
  static const providerDashBoardScreen = '/providerDashBoardScreen';
  static const bookingScreen = '/bookingScreen';
  static const availabilityScreen = '/availabilityScreen';
  static const messageScreen = '/messageScreen';
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
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
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
      case messageScreen:
        return MaterialPageRoute(builder: (_) => const MessageScreen());
      case availabilityScreen:
        return MaterialPageRoute(builder: (_) => const AvailabilityScreen());
      case bookingScreen:
        return MaterialPageRoute(builder: (_) => const BookingScreen());
      case providerDashBoardScreen:
        return MaterialPageRoute(builder: (_) => ProviderDashBoardScreen());
      case categoryInfoScreen:
        final category = settings.arguments as ServiceCategoryEntity;
        return MaterialPageRoute(
          builder: (_) =>
              CategoryInfoScreen(category: category,),
        );
      case markerScreen:
        final category = settings.arguments as ServiceCategoryEntity;
        return MaterialPageRoute(
          builder: (_) => MarketplaceScreen(category: category,),
        );
      case providerProfileScreen:
        return MaterialPageRoute(builder: (_) => const ProviderProfileScreen());
      case updateServiceScreen:
        final service = settings.arguments as ServiceEntity;
        return MaterialPageRoute(
          builder: (_) => UpdateServiceScreen(service: service),
        );
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
