import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderBookingsHeader extends StatelessWidget {
  const ProviderBookingsHeader({super.key});

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
          child: Text('Bookings', style: titleStyle),
        ),
        Text(
          'Confirmed and pending requests from organizers, events, transports, and staffing.',
          style: textTheme.bodySmall?.copyWith(color: AppColours.grey),
        ),
      ],
    );
  }
}
