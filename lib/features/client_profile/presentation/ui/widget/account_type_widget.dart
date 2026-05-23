import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/auth/domain/entities/client.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/icon_non_gradient_container.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/shadow_container_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountTypeWidget extends StatelessWidget {
  final ClientEntity client;

  const AccountTypeWidget({super.key, required this.client});

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

    return  Container(
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
                _accountTypeLabel(client.role),
                style: valueStyle,
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6.w,
                  children: [
                    
                    Text(
                      'Not verified yet',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColours.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        
      ),
    );
  }

  static String _accountTypeLabel(String role) {
    final trimmed = role.trim();
    if (trimmed.isEmpty) {
      return 'Account';
    }
    final normalized = trimmed.toLowerCase();
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
        child,
      ],
    );
  }
}
