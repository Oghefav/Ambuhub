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
      padding: EdgeInsets.all(10.w),
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
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconContainer(isSelected: isSelected, icon: icon),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'I\'m a $role',
                  style: textTheme.titleMedium,
                ),
                Text(
                  roleDescription,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
