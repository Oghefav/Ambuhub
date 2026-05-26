import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderNotificationsHeader extends StatelessWidget {
  const ProviderNotificationsHeader({super.key});

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
          'Alerts when someone purchases or hires your listings, plus hire return reminders.',
          style: textTheme.bodySmall?.copyWith(color: AppColours.grey),
        ),
      ],
    );
  }
}
