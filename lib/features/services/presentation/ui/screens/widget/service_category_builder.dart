import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/custom_divider.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/screens/widget/service_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceCategoryBuilder extends StatelessWidget {
  final String categoryName;
  final List<ServiceEntity> services;
  const ServiceCategoryBuilder({
    super.key,
    required this.categoryName,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(categoryName, style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 4.h),
                CustomDivider(),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ServiceContainer(
              dept: services[index].dept,
              description: services[index].description,
              imageurl: services[index].photoUrls[0],
              title: services[index].title,
            );
          }, childCount: services.length > 4 ? 4 : services.length),
        ),
      ],
    );
  }
}
