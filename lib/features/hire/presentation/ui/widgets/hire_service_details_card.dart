import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/hire_office_location_card.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/hire_return_window_card.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/hire_service_details_top_section.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/shadowed_container.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HireServiceDetailsCard extends StatelessWidget {
  final ServiceEntity service;
  final String billingPeriod;
  const HireServiceDetailsCard({super.key, required this.service, required this.billingPeriod});

  @override
  Widget build(BuildContext context) {
    return ShadowedContainer(
      shadowColor: Color.lerp(AppColours.hireCyanGlow, Colors.white, 0.5)!,
      borderColor: AppColours.hireCyanGlow,
      topGradientColors: const [
        AppColours.hireCyanSky,
        AppColours.penBlue,
      ],
      bodyGradientColors:  [
        AppColours.hireCyanGlow,
        Color.lerp(AppColours.hireCyanGlow, Colors.white, 0.9)!,
        AppColours.white,
        AppColours.hireCyanGlow,
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      bodyStops: const [0.0, 0.1, 0.9, 1.0],
      topStops: const [0.1, 1.0],
      body: Column(
          spacing: 15.h,
          children: [
            HireServiceDetailsTopSection(service: service, billingPeriod: billingPeriod),
            HireOfficeLocationCard(service: service),
            HireReturnWindowCard(service: service),
          ],
        ),
      
    );
  }
}
