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
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsetsGeometry.all(10.h),
      decoration: BoxDecoration(
        border: Border.all(
          // width:isSelected? 0.5 : 1.0,
          color: isSelected
              ? Color.fromRGBO(0, 105, 200, 1.0)
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
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 10.h),
                Text(
                  roleDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
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
