import 'package:ambuhub/core/widgets/client_app_scaffold.dart';
import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/auth/domain/entities/client.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:ambuhub/features/client_dashboard/presentation/ui/widgets/category_card.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_state.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/widgets/error_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientDashBoardScreen extends StatelessWidget {
  const ClientDashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ClientAppScaffold(
      body: BlocBuilder<GetServiceCategoriesBloc, GetServiceCategoriesState>(
        builder: (context, state) {
            if (state is GetServiceCategoriesError) {
              return Center(
                child: ErrorSection(
                  onPressed: () {
                    context.read<GetServiceCategoriesBloc>().add(
                      const GetServiceCategories(),
                    );
                  },
                  errorMessage: state.error ?? 'Failed to load categories',
                ),
              );
            }
            if (state is GetServiceCategoriesSuccess) {
              final categories = state.serviceCategories ?? [];
              final categoryCards = _buildCategoryCards(categories: categories);
              if (categoryCards.isEmpty) {
                return Center(
                  child: ErrorSection(
                    onPressed: () {
                      context.read<GetServiceCategoriesBloc>().add(
                        const GetServiceCategories(),
                      );
                    },
                    errorMessage: 'No categories available',
                  ),
                );
              }
              return ListView(
                children: [
                  Card(
                    margin: EdgeInsets.all(20.r),
                    elevation: 0,
                    color: AppColours.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      side: const BorderSide(
                        color: AppColours.veryLightVividTeal,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.r).copyWith(bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _dashboardGreeting(context),
                            style: textTheme.titleMedium!.copyWith(
                              color: AppColours.vividTeal,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'What would you like to do today?',
                            style: textTheme.bodyMedium,
                          ),
                          SizedBox(height: 15.h),
                          ...categoryCards,
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          return const Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}

ServiceCategoryEntity? _findCategory(
  List<ServiceCategoryEntity> categories,
  String slug,
) {
  for (final category in categories) {
    if (category.slug == slug) {
      return category;
    }
  }
  return null;
}

List<Widget> _buildCategoryCards({
  required List<ServiceCategoryEntity> categories,
}) {
  final cards = <Widget>[];

  final medicalTransport = _findCategory(categories, 'medical-transport');
  if (medicalTransport != null) {
    cards.add(
      CategoryCard(
        category: medicalTransport,
        title: 'Medical transport',
        bulletPoints: const [
          'Event standby and schedule transports',
          'Ground and air options from vetted providers',
          'Match skills to your operating needs',
        ],
        description:
            'Book event standby, scheduled transports, and ground or air options from vetted providers.',
        icon: LucideIcons.truck,
        gradientSectionTitle: 'Browse Medical transport',
      ),
    );
  }

  final personnel = _findCategory(categories, 'personnel');
  if (personnel != null) {
    cards.add(
      CategoryCard(
        category: personnel,
        title: 'Ambulance personnel',
        bulletPoints: const [
          'Medics, drivers, and support staff',
          'Shifts, tours, or short-term coverage',
          'Match skills to your operating needs',
        ],
        description:
            'Find medics, drivers, and support staff for shifts, tours, or short-term coverage.',
        icon: LucideIcons.users,
        gradientSectionTitle: 'Browse Ambulance personnel',
      ),
    );
  }

  final servicing = _findCategory(categories, 'ambulance-servicing');
  if (servicing != null) {
    cards.add(
      CategoryCard(
        category: servicing,
        title: 'Ambulance sales and servicing',
        bulletPoints: const [
          'Sales and servicing in one place',
          'Keep your ambulances running smoothly',
          'Trusted workshops and suppliers',
        ],
        description:
            'Ambulance sales and servicing — vehicles, parts, and workshop care from trusted providers.',
        icon: LucideIcons.wrench,
        gradientSectionTitle: 'Browse Ambulance sales and servicing',
      ),
    );
  }

  final equipment = _findCategory(categories, 'ambulance-equipment');
  if (equipment != null) {
    cards.add(
      CategoryCard(
        category: equipment,
        title: 'Ambulance equipment',
        bulletPoints: const [
          'Stretchers, monitors, and vehicle kit',
          'Buy or sell verified listings',
          'Compare stock and delivery options',
        ],
        description:
            'Buy and sell stretchers, monitors, vehicle kits and other ambulance-related gear.',
        icon: LucideIcons.package,
        gradientSectionTitle: 'Browse Ambulance equipment',
      ),
    );
  }

  return cards;
}

String _dashboardGreeting(BuildContext context) {
  final authState = context.watch<AuthBloc>().state;
  if (authState is AuthSuccess && authState.data is ClientEntity) {
    final client = authState.data as ClientEntity;
    final firstName = client.firstName.trim();
    final lastName = client.lastName.trim();
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return 'Hello, $firstName $lastName';
    }
  }
  return 'Hello, there';
}
