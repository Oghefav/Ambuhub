import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/features/main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_state.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/widgets/error_widget.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/widgets/service_category_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({super.key});

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetServicesBloc>(context).add(GetServices());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetServicesBloc, GetServicesState>(
      builder: (context, state) {
        List<ServiceEntity> medicalTransportCategory = [];
        List<ServiceEntity> ambulancePersonnelCategory = [];
        List<ServiceEntity> ambulanceServicingCategory = [];
        List<ServiceEntity> ambulanceEquipmentCategory = [];
        if (state is GetServicesSuccess) {
          final services = state.services;
          medicalTransportCategory = services!.where((element) {
            return element.serviceCategory == 'Medical transport';
          }).toList();
          ambulancePersonnelCategory = services.where((element) {
            return element.serviceCategory == 'Ambulance personnel';
          }).toList();
          ambulanceServicingCategory = services.where((element) {
            return element.serviceCategory == 'Ambulance servicing';
          }).toList();
          ambulanceEquipmentCategory = services.where((element) {
            return element.serviceCategory == 'Ambulance equipment';
          }).toList();
        }
        return ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: CustomScrollView(
            slivers: [
              CustomAppbar(),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Text(
                        'My Listings',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 15)),
                    if (state is GetServicesLoading)
                      SliverToBoxAdapter(
                        child: Text(
                          'Loading your services...',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),

                    if (state is GetServicesFailure)
                      SliverFillRemaining(
                        child: Center(
                          child: ErrorSection(
                            onPressed: () {
                              BlocProvider.of<GetServicesBloc>(context).add(GetServices());
                            },
                            errorMessage: state.errorMessage!,
                          ),
                        )
                      ),

                    if (state is GetServicesSuccess) ...[
                      SliverToBoxAdapter(
                        child: Text(
                          'Services and equipment you have published, grouped by category.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      if (medicalTransportCategory.isNotEmpty)
                        ServiceCategoryBuilder(
                          categoryName: 'Medical Transport',
                          services: medicalTransportCategory,
                        ),
                      if (ambulancePersonnelCategory.isNotEmpty)
                        ServiceCategoryBuilder(
                          categoryName: 'Ambulance personnel',
                          services: ambulancePersonnelCategory,
                        ),
                      if (ambulanceServicingCategory.isNotEmpty)
                        ServiceCategoryBuilder(
                          categoryName: 'Ambulance Servicing',
                          services: ambulanceServicingCategory,
                        ),
                      if(ambulanceEquipmentCategory.isNotEmpty)
                        ServiceCategoryBuilder(categoryName: 'Ambulance equipment', services: ambulanceEquipmentCategory),
                      if (state.services!.isEmpty) ...[
                        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                        SliverToBoxAdapter(
                          child: DottedBorderContainer(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  vertical: 50.h,
                                  horizontal: 20.w,
                                ),
                                child: Text(
                                  'No services to show yet',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      SliverToBoxAdapter(child: SizedBox(height: 15)),
                      SliverToBoxAdapter(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<NavigationCubit>(
                                context,
                              ).setPage(1);
                            },
                            child: Text(
                              state.services!.isEmpty
                                  ? 'Add a service'
                                  : 'Add another service',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: AppColours.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
