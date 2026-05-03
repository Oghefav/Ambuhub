import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityContainer extends StatelessWidget {
  const ActivityContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColours.white,
      child: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activities',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 10.h),
            _buildActivityItem(context, 'New listing published in Ambulance equipment.'),
            SizedBox(height: 10.h),
            _buildActivityItem(context, 'Booking request received for event standby.'),
            SizedBox(height: 10.h),
            _buildActivityItem(context, 'Listing price updated for oxygen concentrator package.'),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(BuildContext context, String activity) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 243, 245, 247),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(activity, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
