// import 'dart:ui';
// import 'package:ambuhub/dependencies_injection.dart';
// import 'package:ambuhub/features/availablity/presentation/ui/screens/availability_screen.dart';
// import 'package:ambuhub/features/booking/presentation/ui/screen/booking_screen.dart';
// import 'package:ambuhub/features/main_dashboard/presentation/cubit/navigation_cubit.dart';
// import 'package:ambuhub/features/main_dashboard/presentation/ui/screens/dash_board_screen.dart';
// import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/drawer.dart';
// import 'package:ambuhub/features/message/presentation/ui/screen/message_screen.dart';
// import 'package:ambuhub/features/profile/presentation/ui/screen/profile_screen.dart';
// import 'package:ambuhub/features/services/presentation/ui/add_service/screen/add_service_screen.dart';
// import 'package:ambuhub/features/services/presentation/ui/listing/screen/listings_screen.dart';
// import 'package:ambuhub/features/services/presentation/ui/service_detail/service_detail_screen.dart';
// import 'package:ambuhub/features/services/presentation/ui/update_service/update_service_screen.dart';
// import 'package:ambuhub/features/setting/presentation/ui/screens/setting_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

// class MainDashboard extends HookWidget {
//   const MainDashboard({super.key});
//   @override
//   Widget build(BuildContext context) {
//     // final scaffoldKey = sl<GlobalKey<ScaffoldState>>();
//     final isDrawerOpen = useState<bool>(false);
//     final selectedService = context.read<NavigationCubit>().selectedService;

//     return BlocBuilder<NavigationCubit, int>(
//       builder: (context, currentIndex) {
//         final List<Widget> pages = [
//           DashBoardScreen(),
//           AddServiceScreen(key: ValueKey('addServiceScreen$currentIndex')),
//           ListingsScreen(),
//           BookingScreen(),
//           AvailabilityScreen(),
//           MessageScreen(),
//           ProfileScreen(),
//           SettingScreen(),
//           if (selectedService != null) // 8
//             ServiceDetailScreen(service: selectedService)
//           else
//             const SizedBox.shrink(),
//           if (selectedService != null) // 9
//             UpdateServiceScreen(
//               service: selectedService,
//               key: ValueKey('update_${selectedService.id}'),
//             )
//           else
//             const SizedBox.shrink(),
//         ];
//         return Scaffold(
//           // key: scaffoldKey,
//           drawer: AppDrawer(),
//           onDrawerChanged: (isOpen) {
//             isDrawerOpen.value = isOpen;
//           },
//           body: Stack(
//             children: [
//               IndexedStack(index: currentIndex, children: pages),
//               if (isDrawerOpen.value)
//                 Positioned.fill(
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
//                     child: Container(
//                       color: Colors.black.withAlpha(
//                         10,
//                       ), // Almost invisible, but triggers the blur
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
