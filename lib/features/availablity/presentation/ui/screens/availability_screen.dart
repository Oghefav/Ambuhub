import 'package:ambuhub/core/widgets/provider_app_scaffold.dart';
import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/features/availablity/presentation/ui/widgets/availability_empty_placeholder.dart';
import 'package:ambuhub/features/availablity/presentation/ui/widgets/availability_header.dart';
import 'package:ambuhub/features/availablity/presentation/ui/widgets/availability_list_section.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_state.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service_availability/update_service_availability_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service_availability/update_service_availability_state.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailabilityScreen extends HookWidget {
  const AvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    useEffect(() {
      context.read<GetProviderServicesBloc>().add(const GetProviderServices());
      return null;
    }, const []);

    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateServiceAvailabilityBloc,
            UpdateServiceAvailabilityState>(
          listenWhen: (prev, curr) =>
              curr.lastUpdatedService != prev.lastUpdatedService ||
              curr.patchedServiceId != prev.patchedServiceId,
          listener: (context, state) {
            final listingsBloc = context.read<GetProviderServicesBloc>();
            final updated = state.lastUpdatedService;
            if (updated != null) {
              listingsBloc.patchService(updated);
              return;
            }
            final patchId = state.patchedServiceId;
            final patchAvailable = state.patchedIsAvailable;
            if (patchId != null && patchAvailable != null) {
              listingsBloc.patchServiceAvailability(patchId, patchAvailable);
            }
          },
        ),
      ],
      child: ProviderAppScaffold(
        body: BlocBuilder<GetProviderServicesBloc, GetProviderServicesState>(
          builder: (context, listingsState) {
            return CustomScrollView(
              slivers: [
                const CustomAppbar(),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 24.h),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AvailabilityHeader(),
                        if (listingsState is GetProviderServicesLoading) ...[
                          SizedBox(height: 15.h),
                          Text(
                            'Loading your listings...',
                            style: textTheme.bodyLarge,
                          ),
                        ],
                        if (listingsState is! GetProviderServicesLoading) ...[
                          SizedBox(height: 15.h),
                          BlocBuilder<UpdateServiceAvailabilityBloc,
                              UpdateServiceAvailabilityState>(
                            buildWhen: (prev, curr) =>
                                prev.errorMessage != curr.errorMessage,
                            builder: (context, availabilityState) {
                              final message = availabilityState.errorMessage;
                              if (message == null || message.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding: EdgeInsets.only(bottom: 15.h),
                                child: ErrorMessageContainer(
                                  errorMessage: message,
                                ),
                              );
                            },
                          ),
                        ],
                        if (listingsState is GetProviderServicesFailure)
                          ErrorSection(
                            onPressed: () {
                              context.read<GetProviderServicesBloc>().add(
                                    const GetProviderServices(
                                      forceRefresh: true,
                                    ),
                                  );
                            },
                            errorMessage: listingsState.errorMessage ?? '',
                          ),
                        if (listingsState is GetProviderServicesSuccess) ...[
                          if (listingsState.services == null ||
                              listingsState.services!.isEmpty)
                            const AvailabilityEmptyPlaceholder()
                          else
                            AvailabilityListSection(
                              services: listingsState.services!,
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
