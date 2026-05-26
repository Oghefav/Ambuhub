import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/auth/presentation/ui/role/widget/role_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoleSection extends StatelessWidget {
  final ValueNotifier<String> roleSelected;
  const RoleSection({super.key, required this.roleSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25.h),
            Text(
              'How would you like to continue?',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: 25.h),
            Text(
              'Select your role that best describes you',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 25.h),
          GestureDetector(
            onTap: () {
              roleSelected.value = 'patient';
              Navigator.pushNamed(
                context,
                AppRoutes.signUpScreen,
                arguments: 'Client',
              );
            },
            child: RoleCard(
              isSelected: roleSelected.value == 'patient',
              role: 'client',
              roleDescription: 'Book standby and transport, browse listings, and keep your bookings organized.',
              icon: LucideIcons.user,
            ),
          ),
          GestureDetector(
            onTap: () {
              roleSelected.value = 'service_provider';
              Navigator.pushNamed(
                context,
                AppRoutes.signUpScreen,
                arguments: 'Service provider',
              );
            },
            child: RoleCard(
              isSelected: roleSelected.value == 'service_provider',
              role: 'service provider',
              roleDescription: 'Ambulance operators, medics, and vendors listing coverage, shifts, and equipment.',
              icon: LucideIcons.building_2,
            ),
          ),
        ],
      ),
    );
    
  }
}