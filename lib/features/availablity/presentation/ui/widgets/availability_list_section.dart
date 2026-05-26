import 'package:ambuhub/features/availablity/presentation/ui/widgets/availability_service_container.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service_availability/update_service_availability_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service_availability/update_service_availability_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailabilityListSection extends StatelessWidget {
  final List<ServiceEntity> services;

  const AvailabilityListSection({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      UpdateServiceAvailabilityBloc,
      UpdateServiceAvailabilityState
    >(
      builder: (context, availabilityState) {
        return Column(
          children: [
            for (final service in services)
              AvailabilityServiceContainer(
                service: service,
                isUpdating: availabilityState.isUpdating(service.id),
              ),
          ],
        );
      },
    );
  }
}
