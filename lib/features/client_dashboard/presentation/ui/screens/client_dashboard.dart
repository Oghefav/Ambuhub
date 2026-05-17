import 'package:ambuhub/core/widgets/client_app_scaffold.dart';
import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/client_dashboard/presentation/ui/widgets/category_card.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_state.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/widgets/error_widget.dart';
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
          if (state is GetServiceCategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetServiceCategoriesError) {
            return Center(child: ErrorSection(
                onPressed: () {
                  context.read<GetServiceCategoriesBloc>().add(const GetServiceCategories());
                }, 
                errorMessage: 'Failed to load data'));
          }
          if (state.serviceCategories == null) {
            return const Center(child: Text('failed to load data'));
          }
          final medicalTransportCategory = state.serviceCategories?.firstWhere((category) => category.slug == 'medical-transport');
          final ambulancePersonnelCategory = state.serviceCategories?.firstWhere((category) => category.slug == 'personnel');
          final ambulanceServicingCategory = state.serviceCategories?.firstWhere((category) => category.slug == 'ambulance-servicing');
          final ambulanceEquipmentCategory = state.serviceCategories?.firstWhere((category) => category.slug == 'ambulance-equipment');
          return ListView(
            children: [
              Card(
                margin: EdgeInsets.all(20.r),
                elevation: 0,
                color: AppColours.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  side: const BorderSide(color: AppColours.veryLightVividTeal,),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.r).copyWith(bottom: 0),
                  child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello there!',
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
                          CategoryCard(
                            category: medicalTransportCategory!,
                            title: 'Medical transport',
                            bulletPoints: const [
                              'Event standby and schedule transports',
                              'Ground and air options from vetted providers',
                              'Match skills to yur operating needs',
                            ],
                            description:
                                'Find Medics, drivers, and support staff for shifts, tours, or short-term coverage.',
                            icon: LucideIcons.truck,
                            gradientSectionTitle: 'Browse Medical transport',
                            
                          ),
              
                          CategoryCard(
                            category: ambulancePersonnelCategory!,
                            title: 'Ambulance personnel',
                            bulletPoints: const [
                              'Medics, drivers, and support staff',
                              'Shifs, tours, or short-term coverage',
                              'Match skills to your operating needs',
                            ],
                            description:
                                'Find Medics, drivers, and support staff for shifts, tours, or short-term coverage.',
                            icon: LucideIcons.users,
                            gradientSectionTitle: 'Browse Ambulance personnel',
                          ),
              
                          CategoryCard(
                            category: ambulanceServicingCategory!,
                            title: 'Ambulance sales and servicing',
                            bulletPoints: const [
                              'Sales and servicing in one place',
                              'Keep your ambulances running smoothly',
                              'Trusted workshops and suppliers',
                            ],
                            description:
                                'Ambulance sales and servicing-vehicles, parts,and workshop care from trusted providers.',
                            icon: LucideIcons.wrench,
                            gradientSectionTitle: 'Browse Ambulance sales and servicing',
                          ),
              
                          CategoryCard(
                            category: ambulanceEquipmentCategory!,
                            title: 'Ambulance equipment',
                            bulletPoints: const [
                              'Stretchers, monitors, and vehicle kit',
                              'Buy or sell verified listings',
                              'compare stock and delivery options',
                            ],
                            description:
                                'Buy and sell stretchers, monitors, vehicle kits and other ambulance-related gear.',
                            icon: LucideIcons.package,
                            gradientSectionTitle: 'Browse Ambulance equipment',
                          ),
                        ],
                      ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
