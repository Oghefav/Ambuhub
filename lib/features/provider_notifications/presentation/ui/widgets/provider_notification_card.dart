import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/icon_container.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/shadowed_container.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/provider_notifications/domain/entities/provider_notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderNotificationCard extends StatelessWidget {
  final ProviderNotificationEntity notification;
  final VoidCallback? onMarkAsRead;

  const ProviderNotificationCard({
    super.key,
    required this.notification,
    this.onMarkAsRead,
  });

  static const Color _newBadgeBackground = Color(0xFFD6E7FE);

  static const List<Color> _readIconGradient = [
    Color.fromRGBO(137, 153, 176, 1),
    Color.fromRGBO(97, 112, 133, 1),
  ];

  bool get _isUnread => !notification.isRead;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: ShadowedContainer(
          shadowColor: Colors.transparent,
          borderColor: AppColours.veryLightVividTeal,
          bodyGradientColors: const [AppColours.white, AppColours.white],
          topGradientColors: const [
            AppColours.penBlue,
        AppColours.hireCyanElectric,
        AppColours.hireCyanBright,
        
      ],
          bodyStops: const [0.0, 1.0],
          topStops: const [0.0, 0.5, 1.0],
          topHeight: 6.h,
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconGradientContainer(
                icon: LucideIcons.bell,
                size: 18.sp,
                gradientStops: const [0.0, 1.0],
                colors: _isUnread
                    ? const [AppColours.vividTeal, AppColours.teal]
                    : _readIconGradient,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            notification.title,
                            style: textTheme.titleSmall!.copyWith(fontSize: 12.sp),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (_isUnread) ...[
                          SizedBox(width: 8.w),
                          _NewBadge(),
                        ],
                        if (_isUnread && onMarkAsRead != null) ...[
                        const Spacer(),
                        TextButton(
                          onPressed: onMarkAsRead,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            foregroundColor: AppColours.vividTeal,
                          ),
                          child: Text(
                            'Mark as read',
                            style: textTheme.labelSmall?.copyWith(
                              color: AppColours.vividTeal,
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                            ),
                          ),
                        ),
                      ],
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          formatTimeAgo(notification.createdAt),
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: 10.sp,
                            color: AppColours.grey,
                          ),
                        ),
                        
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      notification.body,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColours.grey,
                        height: 1.35,
                      ),
                    ),
                    if (notification.type == 'provider_hire_booked' &&
                        notification.deadlineAt != null) ...[
                      SizedBox(height: 6.h),
                      Text(
                        'Return due: ${formatDateTimeShort(notification.deadlineAt)}',
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    if (notification.receiptNumber != null &&
                        notification.receiptNumber!.trim().isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        'Receipt ${notification.receiptNumber}',
                        style: textTheme.bodySmall?.copyWith(fontSize: 11.sp),
                      ),
                    ],
                    SizedBox(height: 12.h),
                    _ViewListingsButton(
                      onTap: () {
                        context.read<NavigationCubit>().setPage('listings');
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.listingsScreen,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: ProviderNotificationCard._newBadgeBackground,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        'New',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColours.vividTeal,
              fontWeight: FontWeight.w700,
              fontSize: 9.sp,
            ),
      ),
    );
  }
}

class _ViewListingsButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ViewListingsButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: AppColours.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColours.veryLightVividTeal),
        ),
        child: Center(
          child: Row(
            spacing: 10.w,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View listings',
                style: textTheme.titleSmall?.copyWith(
                  color: AppColours.vividTeal,
                  fontSize: 12.sp,
                ),
              ),
              Icon(LucideIcons.external_link, size: 16.sp, color: AppColours.vividTeal),
            ],
          ),
        ),
      ),
    );
  }
}
