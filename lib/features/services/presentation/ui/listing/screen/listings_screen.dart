import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/widgets/app_scaffold.dart';
import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:ambuhub/features/main_dashboard/presentation/cubit/navigation_cubit.dart';
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
    return AppScaffold(
      body: BlocBuilder<GetServicesBloc, GetServicesState>(
        builder: (context, state) {
          if (state is GetServicesSuccess) {
            final services = state.services;
            print(services);
            //   medicalTransportCategory = services!.where((element) {
            //     return element.serviceCategory == 'Medical transport';
            //   }).toList();
            //   ambulancePersonnelCategory = services.where((element) {
            //     return element.serviceCategory == 'Ambulance personnel';
            //   }).toList();
            //   ambulanceServicingCategory = services.where((element) {
            //     return element.serviceCategory == 'Ambulance servicing';
            //   }).toList();
            //   ambulanceEquipmentCategory = services.where((element) {
            //     return element.serviceCategory == 'Ambulance equipment';
            //   }).toList();
          }
          return CustomScrollView(
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
                              BlocProvider.of<GetServicesBloc>(
                                context,
                              ).add(GetServices());
                            },
                            errorMessage: state.errorMessage!,
                          ),
                        ),
                      ),

                    if (state is GetServicesSuccess) ...[
                      ServiceCategoryBuilder(services: state.services!),
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
                              ).setPage('addService');
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.addServiceScreen,
                              );
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
          );
        },
      ),
    );
  }
}
