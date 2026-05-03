import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/activity_container.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/card_builder.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/performance_container.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/search_container.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/small_gradient_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CustomScrollView(
          slivers: [
            CustomAppbar(),
            SliverList(
              delegate: SliverChildListDelegate([
                Card(
                  margin: EdgeInsets.all( 15.r, ),
                  elevation: 0,
                  color: AppColours.white,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DashBoard',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          'Track your provider performance, listings, and activity from one place.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: 10.h,),
                        Row(children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColours.veryLightGrey),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(padding: EdgeInsets.all(10.r),
                            child:Icon(LucideIcons.bell, color: AppColours.grey, size: 18.sp,),)
                          ),
                          SizedBox(width: 10.w,),
                          SmallGradientContainer(iconData: LucideIcons.upload, title: 'Upload listing'),
                        ],),
                        SizedBox(height: 15.h),
                        SearchContainer(searchController: searchController),
                        SizedBox(height: 15.h),
                        CardBuilder( cardNumber: 1, firstText: 'Wallet Balance', secondText: 'Available balance', isWalletBalance: true, amountValue: '1250000'),
                        CardBuilder( cardNumber: 2, firstText: 'Active Listings', numberValue: 18, secondText: '+3 this week'),
                        CardBuilder( cardNumber: 3, firstText: 'Open bookings', secondText: '+2 this week', numberValue: 7),
                        CardBuilder( cardNumber: 4, firstText: 'Unread messages', numberValue: 12, secondText: '4 urgent'),
                        SizedBox(height: 15.h),
                        PerformanceContainer(),
                        SizedBox(height: 15.h),
                        ActivityContainer(),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        
      ),
    );
  }
}



// DottedBorderContainer(
                      //   child: Padding(
                      //     padding: EdgeInsetsGeometry.all(15.h),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           'Next steps',
                      //           style: Theme.of(context).textTheme.titleMedium,
                      //         ),
                      //         BulletPoint(
                      //           text:
                      //               'Add a service to appear in search and category browse.',
                      //         ),
                      //         BulletPoint(
                      //           text:
                      //               'Complete your business profile so organizers can trust your crew.',
                      //         ),
                      //         BulletPoint(
                      //           text:
                      //               'Set availability for event dates and transport windows.',
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),