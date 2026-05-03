import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/widgets/add_service_card.dart';
import 'package:ambuhub/features/services/presentation/ui/widgets/top_section_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddServiceScreen extends StatelessWidget {
  const AddServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CustomScrollView(
        slivers: [
          CustomAppbar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsGeometry.all(15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopSectionContainer(bigText: 'Add service', smallText: 'List standby coverage, scheduled transport, personnel, or equipment for venues and organizers.'),
                  SizedBox(height: 15.h),
                  AddServiceFormCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
