import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/widgets/service_container.dart';
import 'package:ambuhub/features/services/presentation/ui/widgets/category_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceCategoryBuilder extends HookWidget {
  final List<ServiceEntity> services;
  const ServiceCategoryBuilder({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    final selectedCategory = useState<String>('all');

    final categoryNames = useMemoized(
      () {
        final names = services.map((s) => s.serviceCategory.trim()).toSet();
        final sorted = names.toList()..sort();
        return sorted;
      },
      [services],
    );

    final filteredServices = useMemoized(
      () {
        if (selectedCategory.value == 'all') return services;
        final key = selectedCategory.value.toLowerCase();
        return services
            .where(
              (service) =>
                  service.serviceCategory.trim().toLowerCase() == key,
            )
            .toList();
      },
      [services, selectedCategory.value],
    );

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Text(
                'Services and equipment you have published, grouped by category.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 15.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Wrap(
                      spacing: 10.w,
                      children: [
                        CategoryTab(
                          label: 'All',
                          value: 'all',
                          selectedCategory: selectedCategory,
                        ),
                        ...categoryNames.map(
                          (name) => CategoryTab(
                            label: name.capitalizeFirst(),
                            value: name.toLowerCase(),
                            selectedCategory: selectedCategory,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
        if (filteredServices.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ServiceContainer(
                serviceEntity: filteredServices[index],
              ),
              childCount: filteredServices.length,
            ),
          )
        else
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 200.h),
                DottedBorderContainer(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 30.h,
                        horizontal: 20.w,
                      ),
                      child: Text(
                        'No services in this category',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
