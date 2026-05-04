import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/widgets/app_scaffold.dart';
import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/update_service/widgets/update_service_card.dart';
import 'package:ambuhub/features/services/presentation/ui/widgets/top_section_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateServiceScreen extends StatelessWidget {
  final ServiceEntity service;
  const UpdateServiceScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppbar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsGeometry.all(15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.serviceDetailScreen, arguments: service),
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.arrow_left,
                          size: 20.sp,
                          color: AppColours.penBlue,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Back to listing',
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColours.penBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  TopSectionContainer(
                    bigText: 'Update service',
                    smallText:
                        'Change details, photos, or pricing. Saved updates appear on the public category pages after a short refresh.',
                  ),
                  SizedBox(height: 15.h),
                  UpdateServiceFormCard(service: service),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
