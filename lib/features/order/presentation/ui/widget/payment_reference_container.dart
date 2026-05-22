import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentReferenceContainer extends StatelessWidget {
  final OrderEntity order;

  const PaymentReferenceContainer({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyStyle = textTheme.titleSmall!.copyWith(color: 
    AppColours.darkVividTeal, fontSize: 12.sp);
    final referenceStyle = textTheme.bodyMedium?.copyWith(
      letterSpacing: 0.5,
      color:Colors.black
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColours.hireCyanBright,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Text(
            'Payment reference:',
            style: bodyStyle,
          ),
          Text(
            order.paystackReference.toUpperCase(),
            style: referenceStyle,
          ),
          RichText(
            text: TextSpan(
              style: textTheme.bodySmall!.copyWith(fontSize: 12.sp),
              children: [
                TextSpan(
                  text: 'Provider: ',
                  style: bodyStyle,
                ),
                const TextSpan(text: 'Paystack (simulated)'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
