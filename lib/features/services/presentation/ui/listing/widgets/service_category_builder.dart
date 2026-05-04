import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/widgets/service_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceCategoryBuilder extends HookWidget {
  final List<ServiceEntity> services;
  const ServiceCategoryBuilder({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    final selectedCategory = useState<String>('all');
    final filteredServices = useState<List<ServiceEntity>>(services);

    useEffect(() {
      if (selectedCategory.value == 'all') {
        filteredServices.value = services;
      } else {
        filteredServices.value = services
            .where(
              (service) =>
                  service.serviceCategory.toLowerCase() ==
                  selectedCategory.value.toLowerCase(),
            )
            .toList();
      }
      return null;
    }, [selectedCategory.value]);
    return SliverMainAxisGroup(
      slivers: [
        // 1. The Category Selectors (Horizontal)
        SliverToBoxAdapter(
          child: Column(
            children: [
              Text(
                'Services and equipment you have published, grouped by category.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 15.h),
              SingleChildScrollView(
                // Added scroll in case categories overflow screen width
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Wrap(
                      spacing: 10.w,
                      children: [
                        _categoryTab(context, 'All', 'all', selectedCategory),
                        _categoryTab(
                          context,
                          'Medical Transport',
                          'medical transport',
                          selectedCategory,
                        ),
                        _categoryTab(
                          context,
                          'Ambulance Personnel',
                          'ambulance personnel',
                          selectedCategory,
                        ),
                        _categoryTab(
                          context,
                          'Ambulance Servicing',
                          'ambulance servicing',
                          selectedCategory,
                        ),
                        _categoryTab(
                          context,
                          'Ambulance Equipment',
                          'ambulance equipment',
                          selectedCategory,
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

        // 2. The Resulting List
        if (filteredServices.value.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ServiceContainer(
                serviceEntity: filteredServices.value[index],
              ),
              childCount: filteredServices.value.length,
            ),
          )
        else
          const SliverToBoxAdapter(
            child: Center(child: Text('No services found')),
          ),
      ],
    );
  }

  // Helper to keep the build method clean
  Widget _categoryTab(
    BuildContext context,
    String label,
    String value,
    ValueNotifier<String> selected,
  ) {
    return GestureDetector(
      onTap: () => selected.value = value,
      child: _buildCategorySelector(context, label, selected.value == value),
    );
  }

  Widget _buildCategorySelector(
    BuildContext context,
    String categoryName,
    bool isSelected,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        border: isSelected
            ? null
            : Border.all(color: AppColours.veryLightVividTeal, width: 1.w),
        borderRadius: BorderRadius.circular(10.r),
        color: isSelected ? null : Color.fromRGBO(245, 247, 250, 1.0),
        gradient: isSelected
            ? LinearGradient(
                colors: [
                  Color.fromRGBO(9, 82, 227, 1.0),
                  Color.fromRGBO(0, 146, 186, 1.0),
                ],
              )
            : null,
      ),
      child: Text(
        categoryName,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isSelected ? AppColours.white : AppColours.grey,
        ),
      ),
    );
  }
}
// import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/custom_divider.dart';
// import 'package:ambuhub/features/services/domain/enitities/service.dart';
// import 'package:ambuhub/features/services/presentation/ui/listing/widgets/service_container.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ServiceCategoryBuilder extends StatelessWidget {
//   final String categoryName;
//   final List<ServiceEntity> services;
//   const ServiceCategoryBuilder({
//     super.key,
//     required this.categoryName,
//     required this.services,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SliverMainAxisGroup(
//       slivers: [
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: EdgeInsets.only(top: 15.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(categoryName, style: Theme.of(context).textTheme.titleMedium),
//                 SizedBox(height: 4.h),
//                 CustomDivider(),
//                 SizedBox(height: 10.h),
//               ],
//             ),
//           ),
//         ),
//         SliverList(
//           delegate: SliverChildBuilderDelegate((context, index) {
//             return ServiceContainer(
//               serviceEntity: services[index]
//             );
//           }, childCount: services.length > 4 ? 4 : services.length),
//         ),
//       ],
//     );
//   }
// }
