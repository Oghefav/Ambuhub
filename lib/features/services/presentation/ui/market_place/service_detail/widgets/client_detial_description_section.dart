import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/shadow_container_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientDetailDescriptionSection extends StatelessWidget {
  final ServiceEntity service;

  const ClientDetailDescriptionSection({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ShadowContainerTemplate(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 8.h,
          children: [
            Text(
              'Description',
              style: textTheme.titleSmall?.copyWith(
                color: AppColours.darkVividTeal,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              service.description,
              textAlign: TextAlign.start,
              style: textTheme.bodySmall?.copyWith(
                color: AppColours.grey,
                height: 1.4,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
