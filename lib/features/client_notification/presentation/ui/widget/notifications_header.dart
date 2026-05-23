import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsHeader extends StatelessWidget {
  const NotificationsHeader({super.key});

  static const LinearGradient _titleGradient = LinearGradient(
    colors: [AppColours.darkVividTeal, AppColours.vividTeal],
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
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => _titleGradient.createShader(bounds),
          child: Text('Notifications', style: titleStyle),
        ),
        Text(
          'Reminders about hire return deadlines — 24 hours and 1 hour before your item is due back.',
          style: textTheme.bodySmall?.copyWith(color: AppColours.grey),
        ),
      ],
    );
  }
}
