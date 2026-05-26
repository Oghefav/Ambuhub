import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderProfileHeader extends StatelessWidget {
  const ProviderProfileHeader({super.key});

  static const LinearGradient _titleGradient = LinearGradient(
    colors: [AppColours.penBlue, AppColours.vividTeal],
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleLarge?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w700,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        Row(
          spacing: 10.w,
          children: [
            Icon(
              LucideIcons.building_2,
              color: AppColours.hireCyanBright,
              size: 22.sp,
            ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) =>
                  _titleGradient.createShader(bounds),
              child: Text('Profile', style: titleStyle),
            ),
          ],
        ),
        Text(
          'Your contact details and business information used when customers view your listings.',
          style: textTheme.bodySmall?.copyWith(color: AppColours.grey),
        ),
      ],
    );
  }
}
