import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/extensions/pyramid_text_extension.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> bulletPoints;
  final IconData icon;
  final String gradientSectionTitle;
  final ServiceCategoryEntity category;
  const CategoryCard({
    super.key,
    required this.title,
    required this.bulletPoints,
    required this.description,
    required this.icon,
    required this.gradientSectionTitle,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<NavigationCubit>(context).setPage('');
        Navigator.pushNamed(
          context,
          AppRoutes.markerScreen,
          arguments: category,
        );
      },
      child: Card(
        color: AppColours.white,
        margin: EdgeInsets.only(bottom: 20.r),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
          side: const BorderSide(color: AppColours.veryLightGrey),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.h,
                children: [
                  _iconContainer(icon),
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  ...bulletPoints.map(
                    (bulletPoint) => _bulletPointBuilder(bulletPoint, context),
                  ),
                ],
              ),
            ),
            _gradientSection(context, gradientSectionTitle),
          ],
        ),
      ),
    );
  }

  Widget _iconContainer(IconData icon) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColours.vividBlue, AppColours.veryLightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColours.teal.withValues(alpha: 0.1),
            blurRadius: 10.r,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(icon, color: AppColours.white, size: 20.sp),
    );
  }

  Widget _bulletPointBuilder(String bulletPoint, BuildContext context) {
    return Row(
      children: [
        Icon(
          LucideIcons.circle_check,
          color: AppColours.emeraldGreen,
          size: 15.sp,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            bulletPoint,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _gradientSection(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 50.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColours.vividBlue, AppColours.veryLightBlue],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: AppColours.white),
              ).toPyramid(width: constraints.maxWidth);
            },
          ),
        ),
      ),
    );
  }
}
