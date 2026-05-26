import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/auth/domain/entities/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderAccountSection extends StatelessWidget {
  final ServiceProviderEntity provider;

  const ProviderAccountSection({super.key, required this.provider});

  static const Color _verificationBadgeBackground =
      Color.fromRGBO(242, 246, 250, 1);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final labelStyle = textTheme.bodyMedium?.copyWith(
      color: AppColours.grey,
    );
    final valueStyle = textTheme.bodyMedium?.copyWith(
      color: AppColours.darkGrey,
      fontWeight: FontWeight.w600,
    );

    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColours.veryLightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            'Account',
            style: textTheme.titleSmall?.copyWith(
              color: AppColours.vividTeal,
              fontWeight: FontWeight.w700,
            ),
          ),
          _ProfileInfoRow(
            label: 'Account type',
            labelStyle: labelStyle,
            child: Text(
              _accountTypeLabel(provider.role),
              style: valueStyle,
            ),
          ),
          _ProfileInfoRow(
            label: 'Email',
            labelStyle: labelStyle,
            child: Text(
              provider.email,
              style: valueStyle,
              textAlign: TextAlign.end,
            ),
          ),
          _ProfileInfoRow(
            label: 'Email verification',
            labelStyle: labelStyle,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: _verificationBadgeBackground,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Not verified yet',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColours.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Text(
            'Email cannot be changed in the app yet.',
            style: textTheme.bodySmall?.copyWith(
              color: AppColours.grey,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  static String _accountTypeLabel(String role) {
    final trimmed = role.trim();
    if (trimmed.isEmpty) {
      return 'Provider account';
    }
    final normalized = trimmed.toLowerCase().replaceAll('_', ' ');
    if (normalized.contains('service') && normalized.contains('provider')) {
      return 'Service provider account';
    }
    final displayRole =
        '${normalized[0].toUpperCase()}${normalized.substring(1)}';
    return '$displayRole account';
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final Widget child;

  const _ProfileInfoRow({
    required this.label,
    required this.labelStyle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(label, style: labelStyle),
        ),
        Flexible(child: child),
      ],
    );
  }
}
