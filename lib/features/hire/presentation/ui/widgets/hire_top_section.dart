import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HireTopSection extends StatelessWidget {
  const HireTopSection({super.key});

  static const LinearGradient _checkoutTitleGradient = LinearGradient(
    colors: [AppColours.darkVividTeal, AppColours.hireCyanBright],
  );

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w700,
    );

    return Padding(
      padding: EdgeInsets.all(15.r),
      child: Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hireBookingContainer(context),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) =>
                _checkoutTitleGradient.createShader(bounds),
            child: Text('Hire checkout', style: titleStyle),
          ),
          Text(
            'Paystack is not connected yet. Completing payment runs a temporary simulation only.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _hireBookingContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColours.verylightTeal,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColours.hireCyanGlow),
        boxShadow: [
          BoxShadow(
            color: AppColours.hireCyanGlow.withAlpha(100),
            blurRadius: 10.r,
          ),
        ],
      ),
      child: Row(
        spacing: 5.w,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.sparkles, color: AppColours.hireCyanAccent, size: 15.sp),
          Text('Hire BOOKING', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColours.hireNavyBlue, fontSize: 11.sp)),
        ],
      ),
    );
  }
}
