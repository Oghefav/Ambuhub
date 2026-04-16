import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/bullet_point.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/card_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(Icons.menu),
            ),
            title: Text('Provider'),
            titleTextStyle: Theme.of(context).textTheme.titleMedium,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
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
                      'Overview of your standby, transport, personnel, and equipment activity on Ambuhub. Detailed metrics will appear her once booking go live.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 15.h),
                    CardBuilder(titleText: 'Active Listings'),
                    CardBuilder(titleText: 'Open Bookings'),
                    CardBuilder(titleText: 'Unread messages'),
                    DottedBorderContainer(
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Next steps',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            BulletPoint(
                              text:
                                  'Add a service to appear in search and category browse.',
                            ),
                            BulletPoint(
                              text:
                                  'Complete your business profile so organizers can trust your crew.',
                            ),
                            BulletPoint(
                              text:
                                  'Set availability for event dates and transport windows.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
