import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/icon_container.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/shadowed_container.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:ambuhub/features/order/presentation/ui/order_receipt_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItemsBuilder extends StatelessWidget {
  final OrderEntity order;

  static const LinearGradient _totalGradient = LinearGradient(
    colors: [AppColours.vividTeal, AppColours.hireCyanBright],
  );

  const OrderItemsBuilder({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final paidLabel = formatDateTimeLongOrNull(order.paidAt ?? order.createdAt);
    final lineCount = order.lineCount;
    final linesLabel = _linesCountLabel(lineCount);

    return ShadowedContainer(
      bodyStops: const [0.0, 0.1, 0.8, 1.0],
      topStops: const [0.0, 0.5, 1.0],
      shadowColor: Color.lerp(
        AppColours.hireCyanBright,
        AppColours.white,
        0.7,
      )!,
      topGradientColors: const [
        AppColours.hireCyanElectric,
        AppColours.hireCyanBright,
        AppColours.darkVividTeal,
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      bodyGradientColors: [
        Color.lerp(AppColours.hireCyanBright, AppColours.white, 0.7)!,
        AppColours.white,
        AppColours.white,
        Color.lerp(AppColours.hireCyanBright, AppColours.white, 0.7)!,
      ],
      borderColor: Color.lerp(
        AppColours.hireCyanBright,
        AppColours.white,
        0.5,
      )!,
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconGradientContainer(
                  gradientStops: const [0.0, 1.0],
                  icon: LucideIcons.receipt,
                  colors: const [
                    AppColours.hireCyanBright,
                    AppColours.hireCyanDeep,
                  ],
                  size: 25.sp,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RECEIPT',
                        style: textTheme.bodySmall?.copyWith(fontSize: 9.sp),
                      ),
                      Text(
                        order.receiptNumber,
                        style: textTheme.titleSmall?.copyWith(
                          color: AppColours.veryDarkBlue,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'TOTAL',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColours.grey,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) =>
                          _totalGradient.createShader(bounds),
                      child: Text(
                        formatCurrency(order.subtotalNgn),
                        style: textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              spacing: 8.w,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: _borderedChip(
                    backgroundColor: AppColours.white,
                    child: Center(
                      child: Text(
                        paidLabel != null && paidLabel.isNotEmpty
                            ? 'Paid $paidLabel'
                            : 'Paid —',
                        style: textTheme.bodySmall?.copyWith(fontSize: 9.sp),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColours.hireCyanIce),
                  ),
                  child: Text(
                    linesLabel,
                    style: textTheme.bodySmall?.copyWith(fontSize: 9.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.orderReceiptScreen,
                arguments: OrderReceiptArgs.fromOrder(order),
              ),
              child: _borderedChip(
                backgroundColor: AppColours.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 6.w,
                  children: [
                    Text(
                      'View receipt',
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColours.darkVividTeal,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                      ),
                    ),
                    Icon(
                      LucideIcons.external_link,
                      size: 14.sp,
                      color: AppColours.hireCyanDeep,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _linesCountLabel(int count) {
    if (count == 1) return '1 line';
    return '$count lines';
  }

  Widget _borderedChip({
    required Widget child,
    required Color backgroundColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColours.hireCyanIce),
      ),
      child: child,
    );
  }
}
