import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/icon_container.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderReceiptTopSection extends StatelessWidget {
  final OrderEntity order;

  static const LinearGradient _receiptNumberGradient = LinearGradient(
    colors: [AppColours.darkVividTeal, AppColours.hireCyanBright],
  );

  const OrderReceiptTopSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      spacing: 10.h,
      children: [
        Row(
          spacing: 10.w,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 3.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColours.hireCyanTeal),
                    color: Color.lerp(AppColours.hireCyanTeal, AppColours.white, 0.8),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    spacing: 5.w,
                    children: [
                       Icon(LucideIcons.file, color: AppColours.hireCyanTeal, size: 12.sp,),
                      Text('AMBUHUB RECEIPT', style: textTheme.bodySmall?.copyWith(fontSize: 9),)
                    ],
                  )
                ),
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) =>
                      _receiptNumberGradient.createShader(bounds),
                  child: Text(
                    order.receiptNumber,
                    style: textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Issued ',
                        style: textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: formatDateTimeShort(order.createdAt ?? order.paidAt),
                        style: textTheme.bodySmall!.copyWith( color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const Divider(
          color: AppColours.hireCyanIce,
        )
      ],
    );
  }
}
