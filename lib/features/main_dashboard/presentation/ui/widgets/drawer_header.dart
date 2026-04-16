import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 15.w,
            vertical: 8.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ambuhub',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColours.vividTeal,
                  fontSize: 20.sp,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(LucideIcons.x, size: 20.sp, color: AppColours.grey),
              ),
            ],
          ),
        ),
        CustomDivider(),
      ],
    );
  }
}
