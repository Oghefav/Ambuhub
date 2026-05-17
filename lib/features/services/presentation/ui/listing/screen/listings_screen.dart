import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/widgets/provider_app_scaffold.dart';
import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_state.dart';
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
    // Bloc returns cached provider listings when available; refetches only on first visit or after mutations.
    context.read<GetProviderServicesBloc>().add(const GetProviderServices());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ProviderAppScaffold(
      body: BlocBuilder<GetProviderServicesBloc, GetProviderServicesState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              const CustomAppbar(),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Text('My Listings', style: textTheme.displayLarge),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 15)),
                    if (state is GetProviderServicesLoading)
                      SliverToBoxAdapter(
                        child: Text(
                          'Loading your services...',
                          style: textTheme.bodyLarge,
                        ),
                      ),

                    if (state is GetProviderServicesFailure)
                      SliverFillRemaining(
                        child: Center(
                          child: ErrorSection(
                            onPressed: () {
                              BlocProvider.of<GetProviderServicesBloc>(
                                context,
                              ).add(
                                const GetProviderServices(forceRefresh: true),
                              );
                            },
                            errorMessage: state.errorMessage!,
                          ),
                        ),
                      ),

                    if (state is GetProviderServicesSuccess &&
                        state.services != null &&
                        state.services!.isNotEmpty) ...[
                      ServiceCategoryBuilder(services: state.services!),
                    ],
                    if (state is GetProviderServicesSuccess &&
                        (state.services == null ||
                            state.services!.isEmpty)) ...[
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
                                style: textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SliverToBoxAdapter(child: SizedBox(height: 15)),
                    if (state is GetProviderServicesSuccess)
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
                              (state.services == null ||
                                      state.services!.isEmpty)
                                  ? 'Add a service'
                                  : 'Add another service',
                              style: textTheme.bodyMedium!
                                  .copyWith(color: AppColours.blue),
                            ),
                          ),
                        ),
                      ),
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
