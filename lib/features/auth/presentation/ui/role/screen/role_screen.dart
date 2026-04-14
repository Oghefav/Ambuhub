import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/bottom_text.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/gradient_background.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/navigation_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoleScreen extends HookWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roleSelected = useState<String>('');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          GradientBackground(),
          Align(
            alignment: Alignment.center,
            child: _buildBody(context, roleSelected),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, ValueNotifier<String> roleSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _bodyCard(context, roleSelected),
        SizedBox(height: 15.h),
        BottomText(),
      ],
    );
  }

  Widget _bodyCard(BuildContext context, ValueNotifier<String> roleSelected) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(15.w),
      color: AppColours.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
        side: BorderSide(color: AppColours.veryLightVividTeal),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create an account',
              style: Theme.of(
                context,
              ).textTheme.displayMedium!.copyWith(fontSize: 25.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              'Choose how you will use Ambuhub. You can use a different email for each role if needed.',
            ),
            SizedBox(height: 25.h),
            GestureDetector(
              onTap: () {
                roleSelected.value = 'patient';
                Navigator.pushNamed(
                  context,
                  AppRoutes.signUpScreen,
                  arguments: 'Patient',
                );
              },
              child: _buildRoleCard(
                context,
                roleSelected.value == 'patient',
                'patient',
                'Book standby and transport, browse listings, and keep your bookings organized.',
                LucideIcons.user,

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
              child: _buildRoleCard(
                context,
                roleSelected.value == 'service_provider',
                'service provider',
                'Ambulance operators, medics, and vendors listing coverage, shifts, and equipment.',
                LucideIcons.building_2,
              ),
            ),

            SizedBox(height: 10.h),
            NavigationText(firstText: 'Already have an account? ', secondText: 'Sign in', routeName: AppRoutes.loginScreen)
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context,
    bool isSelected,
    String role,
    String roleDescription,
    IconData icon,
  ) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _iconContainer(isSelected, icon),
          SizedBox(height: 10.h),
          Text(
            'Sign Up as a $role',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 10.h),
          Text(roleDescription, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _iconContainer(bool isSelected, IconData icon) {
    return AnimatedContainer(
      width: isSelected ? 50 : 40,
      height: isSelected ? 50 : 40,
      duration: Duration(microseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isSelected ? 10.r : 8.r),
        color: AppColours.blue,
      ),
      child: Center(child: Icon(icon, color: Colors.white)),
    );
  }
}
