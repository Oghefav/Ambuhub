import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/category_info/widget/service_item_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeptSectionBuilder extends StatelessWidget {
  final String deptName;
  final List<ServiceEntity> services;
  final bool? isLoggedIn;
  const DeptSectionBuilder({
    super.key,
    required this.deptName,
    required this.services,
    this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    final int servicesLength = services.length;
    final textTheme = Theme.of(context).textTheme;
    return SliverPadding(
      padding: EdgeInsets.only(left: 15.w),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric( vertical: 10.h),
              child: Text(deptName, style: textTheme.titleSmall),
            ),
          ),
          SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1/2,
                ),
                itemCount: servicesLength,
                itemBuilder: (context, index) {
                  return ServiceItemBuilder(service: services[index]);
                },
              ),
        ],
      ),
    );
  }
}
