import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/auth/presentation/ui/role/widget/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoleCard extends StatelessWidget {
  final bool isSelected;
  final String role;
  final String roleDescription;
  final IconData icon;
  const RoleCard({
    super.key,
    required this.isSelected,
    required this.role,
    required this.roleDescription,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsetsGeometry.all(10.h),
      decoration: BoxDecoration(
        border: Border.all(
          // width:isSelected? 0.5 : 1.0,
          color: isSelected
              ? AppColours.selectedBlue
              : AppColours.veryLightVividTeal,
        ),
        borderRadius: BorderRadius.circular(10.r),
        color: isSelected
            ? AppColours.veryLightVividTeal.withAlpha(120)
            : AppColours.lighterTeal,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 250.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'I\'m a $role',
                  maxLines: 3,
                  style: textTheme.titleSmall,
                ),
                SizedBox(height: 10.h),
                Text(
                  roleDescription,
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          IconContainer(isSelected: isSelected, icon: icon),
        ],
      ),
    );
  }
}
