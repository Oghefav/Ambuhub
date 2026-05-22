import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/shadow_container_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ClientDetailScheduleSection extends StatelessWidget {
  final ServiceEntity service;

  static const Color _borderColor = AppColours.hireCyanIce;
  static const LinearGradient _titleGradient = LinearGradient(
    colors: [AppColours.darkVividTeal, AppColours.vividTeal],
  );

  const ClientDetailScheduleSection({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final lightFill = Color.lerp(_borderColor, AppColours.white, 0.92)!;
    final listingType = service.listingType?.toLowerCase() ?? '';
    final isSale = listingType == 'sale';
    final isHire = listingType == 'hire';
    final titleStyle = textTheme.titleSmall?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w700,
    );

    return ShadowContainerTemplate(
      bodyStops: const [0.0, 0.1, 0.8, 1.0],
      bodyColors: [
        AppColours.hireCyanIce,
        Color.lerp(AppColours.hireCyanIce, AppColours.white, 0.7)!,
        Color.lerp(AppColours.hireCyanIce, AppColours.white, 0.97)!,
        AppColours.hireCyanIce,
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.h,
        children: [
          _chip(
              backgroundColor: AppColours.frostBlue,
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
              child: Text(
                (service.listingType ?? 'SERVICE').toUpperCase(),
                style: textTheme.bodySmall?.copyWith(
                  color: AppColours.vividTeal,
                  fontWeight: FontWeight.w600,
                  fontSize: 9.sp,
                ),
              ),
            ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) =>
                  _titleGradient.createShader(bounds),
              child: Text(
                service.title.toTitleCase(),
                style: titleStyle,
              ),
            ),
            Row(
              spacing: 8.w,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _chip(
                  backgroundColor: AppColours.white,
                  child: _PriceLabel(
                    price: service.price,
                    pricePeriod: isSale ? null : service.pricePeriod,
                    textTheme: textTheme,
                  ),
                ),
                _chip(
                  backgroundColor: lightFill,
                  child: Text(
                    _stockLabel(service.stock),
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColours.darkVividTeal,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
            if (isHire && service.hireReturnWindow != null)
              _chip(
                backgroundColor: lightFill,
                child: RichText(
                  text: TextSpan(
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: 10.sp,
                      color: AppColours.grey,
                    ),
                    children: [
                      TextSpan(
                        text: 'Return schedule: ',
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColours.vividTeal,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                        ),
                      ),
                      TextSpan(
                        text: _formatWeeklyWindow(service.hireReturnWindow!),
                      ),
                    ],
                  ),
                ),
              ),
            if (_hasLocation(service))
              _chip(
                backgroundColor: lightFill,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.w,
                  children: [
                    Icon(
                      LucideIcons.map_pin,
                      color: _borderColor,
                      size: 16.sp,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4.h,
                        children: [
                          if (service.officeAddress != null &&
                              service.officeAddress!.trim().isNotEmpty)
                            Text(
                              service.officeAddress!,
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColours.darkVividTeal,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.sp,
                              ),
                            ),
                          if (_locationRegionLine(service).isNotEmpty)
                            Text(
                              _locationRegionLine(service),
                              style: textTheme.bodySmall?.copyWith(
                                fontSize: 10.sp,
                                color: AppColours.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      
    );
  }

  static String _stockLabel(int? stock) {
    if (stock == null) return 'In stock';
    return 'In stock: $stock';
  }

  static String _formatWeeklyWindow(WeeklyTimeWindowEntity window) {
    final days = window.formattedDaysOfWeek.replaceAll(' - ', '–');
    final start = _formatWatTime(window.timeStart);
    final end = _formatWatTime(window.timeEnd);
    return '$days, $start – $end (WAT)';
  }

  static String _formatWatTime(String hhMm) {
    final trimmed = hhMm.trim();
    if (trimmed.isEmpty) return '';
    final parts = trimmed.split(':');
    final hour = int.tryParse(parts.first);
    if (hour == null) return trimmed;
    final minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    final dt = DateTime(2000, 1, 1, hour, minute);
    return DateFormat('h:mm a').format(dt);
  }

  static bool _hasLocation(ServiceEntity service) {
    return (service.officeAddress != null &&
            service.officeAddress!.trim().isNotEmpty) ||
        _locationRegionLine(service).isNotEmpty;
  }

  static String _locationRegionLine(ServiceEntity service) {
    return formatLocationRegionLine(
      stateProvinceName: service.stateProvinceName,
      stateProvince: service.stateProvince,
      country: service.country ?? 'Nigeria',
    );
  }

  Widget _chip({
    required Color backgroundColor,
    required Widget child,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: _borderColor),
      ),
      child: child,
    );
  }
}

class _PriceLabel extends StatelessWidget {
  final int? price;
  final String? pricePeriod;
  final TextTheme textTheme;

  const _PriceLabel({
    required this.price,
    required this.pricePeriod,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final priceText = formatCurrency(price ?? 0);
    final period = pricePeriod?.trim().toLowerCase();

    return RichText(
      text: TextSpan(
        style: textTheme.bodySmall?.copyWith(fontSize: 10.sp),
        children: [
          TextSpan(
            text: priceText,
            style: textTheme.titleSmall?.copyWith(
              color: AppColours.darkVividTeal,
              fontWeight: FontWeight.w700,
              fontSize: 11.sp,
            ),
          ),
          if (period != null && period.isNotEmpty)
            TextSpan(
              text: ' (per $period)',
              style: textTheme.bodySmall?.copyWith(
                color: AppColours.grey,
                fontSize: 9.sp,
              ),
            ),
        ],
      ),
    );
  }
}
