import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildHeader extends StatelessWidget {
  final String emptyDescription;
  final Gradient gradient;
  const BuildHeader({super.key, required this.emptyDescription, required this.gradient});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleLarge?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w700,
    );
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10.w,
          children: [
            Icon(
              Icons.favorite,
              color: AppColours.hireMagentaRose,
              size: 22.sp,
            ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) =>
                  gradient.createShader(bounds),
              child: Text('Favourites', style: titleStyle),
            ),
          ],
        ),
        Text(
          emptyDescription,
          style: textTheme.bodySmall?.copyWith(color: AppColours.grey),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.markerScreen),
          child: Text(
            'Browse Services',
            style: textTheme.bodySmall?.copyWith(
              color: AppColours.vividTeal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}