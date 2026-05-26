import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/service_detail/widgets/short_card_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceOfficeLocationSection extends StatelessWidget {
  final ServiceEntity service;

  const ServiceOfficeLocationSection({super.key, required this.service});

  static bool hasLocation(ServiceEntity service) {
    return _hasText(service.country) ||
        _hasText(service.stateProvinceName) ||
        _hasText(service.stateProvince) ||
        _hasText(service.officeAddress);
  }

  static bool _hasText(String? value) => value != null && value.trim().isNotEmpty;

  static String? _stateDisplay(ServiceEntity service) {
    if (_hasText(service.stateProvinceName)) {
      return service.stateProvinceName!.trim();
    }
    if (_hasText(service.stateProvince)) {
      return service.stateProvince!.trim();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (!hasLocation(service)) {
      return const SizedBox.shrink();
    }

    final textTheme = Theme.of(context).textTheme;
    final country = service.country?.trim();
    final state = _stateDisplay(service);
    final address = service.officeAddress?.trim();

    return ShortCardBuilder(
      topSection: Row(
        children: [
          Icon(
            LucideIcons.map_pin,
            size: 14.sp,
            color: AppColours.vividTeal,
          ),
          SizedBox(width: 8.w),
          Text(
            'OFFICE LOCATION',
            style: textTheme.labelMedium?.copyWith(
              color: AppColours.vividTeal,
              fontWeight: FontWeight.w600,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
      bottomSection: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_hasText(country)) ...[
            _LocationField(
              label: 'Country',
              value: country!,
            ),
            SizedBox(height: 10.h),
          ],
          if (state != null) ...[
            _LocationField(
              label: 'State / province',
              value: state,
            ),
            SizedBox(height: 10.h),
          ],
          if (_hasText(address))
            _LocationField(
              label: 'Address',
              value: address!,
            ),
        ],
      ),
    );
  }
}

class _LocationField extends StatelessWidget {
  final String label;
  final String value;

  const _LocationField({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: AppColours.grey,
            fontSize: 11.sp,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: textTheme.bodySmall?.copyWith(
            color: AppColours.darkGrey,
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}
