import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyServiceBuilder extends StatelessWidget {
  const EmptyServiceBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(bottom: 15.h),
        child: Column(
          children: [
            SizedBox(height: 25.h),
            DottedBorderContainer(
              color: AppColours.verylightTeal,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(25.h),
                  child: Column(
                    children: [
                      Text(
                        'No listings match the selected filter',
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}