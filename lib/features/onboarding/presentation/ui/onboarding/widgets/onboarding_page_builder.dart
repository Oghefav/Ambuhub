import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPageBuilder extends StatelessWidget {
  final ServiceCategoryEntity category;
  const OnboardingPageBuilder({super.key, required this.category});

  String getImage(String categorySlug) {
    switch (categorySlug) {
      case final String slug when slug.contains('equipment'):
        return 'assets/images/equipment.webp';
      case final String slug when slug.contains('personnel'):
        return 'assets/images/personnel.webp';
      case final String slug when slug.contains('transport'):
        return 'assets/images/transport.webp';
      default:
        return 'assets/images/servicing.webp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColours.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: const BorderSide(color: AppColours.veryLightVividTeal),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.asset(getImage(category.slug), fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 15.h),
                Text(
                  category.note,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<GetMarketplaceServicesBloc>(context).add(
                      GetMarketplaceServices(categorySlug: category.slug),
                    );
                    Navigator.pushNamed(
                      context,
                      AppRoutes.categoryInfoScreen,
                      arguments: category,
                    );
                  },
                  child: Text(
                    'View services',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColours.blue,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
