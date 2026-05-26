import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/service_detail/widgets/delete_listing_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailTopSection extends StatelessWidget {
  final ServiceEntity service;

  static const Color _hiddenMarketplaceTextColor = Color(0xFFF8F1C6);

  const DetailTopSection({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: const LinearGradient(
          colors: [
            AppColours.midnightBlue,
            AppColours.midnightIndigo,
            AppColours.darkIndigo,
          ],
          stops: [0.2, 0.5, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(15.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textContainer(context, service.serviceCategory.toUpperCase()),
                SizedBox(height: 10.h),
                _textContainer(context, service.dept),

                if (service.listingType != null) ...[
                  SizedBox(height: 10.h),
                  _textContainer(
                    context,
                    service.listingType!.toTitleCase(),
                    fillColor: AppColours.oceanBlue,
                  ),
                ],
                if (_isHiddenFromMarketplace(service)) ...[
                  SizedBox(height: 10.h),
                  _textContainer(
                    context,
                    'Hidden from marketplace',
                    textColor: _hiddenMarketplaceTextColor,
                  ),
                ],
                SizedBox(height: 10.h),
                Text(
                  service.title.toTitleCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleLarge!.copyWith(
                    color: AppColours.white,
                  ),
                ),
                SizedBox(height: 15.h),
                if (_createdLabel(service) != null) ...[
                  Row(
                    children: [
                      Icon(
                        LucideIcons.calendar,
                        color: AppColours.veryLightGrey,
                        size: 12.sp,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        _createdLabel(service)!,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColours.veryLightGrey,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                ],
                if (_updatedLabel(service) != null)
                  Row(
                    children: [
                      Icon(
                        LucideIcons.calendar_clock,
                        color: AppColours.veryLightGrey,
                        size: 12.sp,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        _updatedLabel(service)!,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColours.veryLightGrey,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<NavigationCubit>(context).setPage('');
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.updateServiceScreen,
                          arguments: service,
                        );
                      },
                      child: _buttonContainer(
                        context,
                        text: 'Update listing',
                        icon: LucideIcons.pencil,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () =>
                          DeleteListingDialog.show(context, service),
                      child: _buttonContainer(
                        context,
                        text: 'Delete',
                        icon: LucideIcons.trash_2,
                        borderColor: AppColours.mauve,
                        backgroundColor: AppColours.darkPurple,
                        foregroundColor: AppColours.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _textContainer(
    BuildContext context,
    String text, {
    Color? borderColor,
    Color? fillColor,
    Color? textColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: fillColor ?? AppColours.slateBlue,
        borderRadius: BorderRadius.circular(15.r),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: 10.sp,
          color: textColor ??
              (fillColor != null
                  ? AppColours.white
                  : AppColours.veryLightGrey),
        ),
      ),
    );
  }

  bool _isHiddenFromMarketplace(ServiceEntity service) {
    return service.available != true;
  }

  Widget _buttonContainer(
    BuildContext context, {
    required String text,
    required IconData icon,
    Color? borderColor,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return Container(
      width: 140.w,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColours.white,
        borderRadius: BorderRadius.circular(8.r),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 13.sp,
                color: foregroundColor ?? AppColours.penBlue,
              ),
              SizedBox(width: 5.w),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: foregroundColor ?? AppColours.penBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _createdLabel(ServiceEntity service) {
    final formatted = formatReviewDateOrNull(service.createdAt);
    if (formatted == null) return null;
    return 'Created $formatted';
  }

  String? _updatedLabel(ServiceEntity service) {
    final formatted = formatReviewDateOrNull(service.updatedAt);
    if (formatted == null) return null;
    return 'Updated $formatted';
  }
}
