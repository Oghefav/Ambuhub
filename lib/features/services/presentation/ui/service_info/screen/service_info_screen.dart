import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_state.dart';
import 'package:ambuhub/features/services/presentation/ui/service_info/widget/dept_section_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceInfoScreen extends StatelessWidget {
  final ServiceCategoryEntity category;
  const ServiceInfoScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      body: SafeArea(
        child: BlocBuilder<GetServicesBloc, GetServicesState>(
          builder: (context, state) {
            if (state is GetServicesLoading) {
              return const Center(
                child: CupertinoActivityIndicator(color: AppColours.blue),
              );
            }
            if (state is GetServicesSuccess) {
              final services = state.services;
              return CustomScrollView(
                slivers: [
                   SliverMainAxisGroup(
                      slivers: [
                        _topSection(context, category),
                        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                        if (services!.isEmpty) _emptyServiceBuilder(context),

                        ...category.departments.map((dept) {
                          final List<ServiceEntity> deptServices = services
                              .where((e) => e.dept == dept.name)
                              .toList();
                          if (deptServices.isEmpty) {
                            return const SliverToBoxAdapter(
                              child: SizedBox.shrink(),
                            );
                          }
                          return DeptSectionBuilder(
                            deptName: dept.name,
                            services: deptServices,
                          );
                        }),
                      ],
                    ),
                  
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

Widget _emptyServiceBuilder(BuildContext context) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          SizedBox(height: 25.h),
          DottedBorderContainer(
            color: AppColours.verylightTeal,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(25.h),
                child: Column(
                  children: [
                    Text(
                      'No listings in this category yet. Check ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
      
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        'back soon or explore other services',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Text(
                      'from the home page.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _topSection(BuildContext context, ServiceCategoryEntity category) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: category.bannerUrl,
                progressIndicatorBuilder: (context, url, loadingProgress) {
                  return const Center(
                    child: CupertinoActivityIndicator(color: AppColours.blue),
                  );
                },
                errorWidget: (context, url, error) {
                  return const Center(child: Icon(Icons.error));
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Text(category.name, style: Theme.of(context).textTheme.titleLarge),
          Text(category.note, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    ),
  );
}
