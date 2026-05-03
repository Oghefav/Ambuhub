import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_state.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/widgets/error_widget.dart';
import 'package:ambuhub/features/services/presentation/ui/service_info/widget/dept_section_builder.dart';
import 'package:ambuhub/features/services/presentation/ui/service_info/widget/search_section.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceInfoScreen extends HookWidget {
  final ServiceCategoryEntity category;
  const ServiceInfoScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final List<String> depts = category.departments
        .map((dept) => dept.name)
        .toList();
    depts.insert(0, 'All Departments');
    final List<String> listingTypes = [
      'All Types',
      'Sale',
      'Rent',
      'Not Specified',
    ];
    final searchController = useTextEditingController();
    final deptValue = useState<String>('All Departments');
    final listingTypeValue = useState<String>('All Types');
    final filteredServices = useState<List<ServiceEntity>>([]);
    final services = useState<List<ServiceEntity>>([]);

    final searchText = useValueListenable(searchController);

    useEffect(() {
      final query = searchText.text.toLowerCase().trim();
      final intQuery = int.tryParse(query);
      filteredServices.value = services.value.where((service) {
        // 1. SEARCH FILTER (Text or Number)
        bool matchesSearch =
            query.isEmpty ||
            service.title.toLowerCase().contains(query) ||
            service.description.toLowerCase().contains(query) ||
            service.dept.toLowerCase().contains(query) ||
            (service.listingType?.toLowerCase().contains(query) ?? false) ||
            (intQuery != null &&
                (service.stock == intQuery || service.price == intQuery));

        // 2. DEPARTMENT FILTER
        bool matchesDept =
            deptValue.value == 'All Departments' ||
            service.dept == deptValue.value;

        // 3. LISTING TYPE FILTER
        bool matchesType;
        if (listingTypeValue.value == 'All Types') {
          matchesType = true;
        } else if (listingTypeValue.value == 'Not Specified') {
          matchesType = service.listingType == null;
        } else {
          matchesType =
              service.listingType?.toLowerCase() ==
              listingTypeValue.value.toLowerCase();
        }

        // A service is kept ONLY if it matches ALL three rules
        return matchesSearch && matchesDept && matchesType;
      }).toList();

      return null;
    }, [searchText, deptValue.value, listingTypeValue.value]);

    return Scaffold(
      backgroundColor: AppColours.white,
      body: SafeArea(
        child: BlocListener<GetServicesBloc, GetServicesState>(
          listener: (context, state) {
            if (state is GetServicesSuccess) {
              final data = state.services;
              services.value = data ?? [];
              filteredServices.value = services.value;
            }
          },
          child: BlocBuilder<GetServicesBloc, GetServicesState>(
            builder: (context, state) {
              if (state is GetServicesLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(color: AppColours.blue),
                );
              }
              if (state is GetServicesFailure) {
                return  Center(
                  child: SliverFillRemaining(
                    child: Center(
                      child: ErrorSection(onPressed: () => context.read<GetServicesBloc>().add(GetServiceInfo(categorySlug: category.slug)), errorMessage: state.errorMessage!),
                    ),
                  ),
                );
              }
              if (state is GetServicesSuccess) {
                return CustomScrollView(
                  slivers: [
                    SliverMainAxisGroup(
                      slivers: [
                        _topSection(context, category),
                        SliverToBoxAdapter(
                          child: SearchSection(
                            listingTypes: listingTypes,
                            searchController: searchController,
                            depts: depts,
                            onChangeDept: (value) => deptValue.value = value!,
                            onChangeListingType: (value) =>
                                listingTypeValue.value = value!,
                          ),
                        ),
                        if (filteredServices.value.isEmpty)
                          _emptyServiceBuilder(context),

                        ...category.departments.map((dept) {
                          final List<ServiceEntity> deptServices =
                              filteredServices.value
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
                      'No listings match the selected filter',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 5.w),
                    //   child: Text(
                    //     'back soon or explore other services',
                    //     style: Theme.of(context).textTheme.bodyLarge,
                    //   ),
                    // ),
                    // Text(
                    //   'from the home page.',
                    //   style: Theme.of(context).textTheme.bodyLarge,
                    // ),
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
                  return const SizedBox.shrink();
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
