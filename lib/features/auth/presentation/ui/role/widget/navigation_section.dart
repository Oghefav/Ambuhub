import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/navigation_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationSection extends StatelessWidget {
  const NavigationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(LucideIcons.arrow_left, size: 20.sp),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Previous',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              NavigationText(
                firstText: 'Already have an account? ',
                secondText: 'Log in',
                routeName: AppRoutes.loginScreen,
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey),
      ],
    );
  }
}
