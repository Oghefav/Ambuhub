import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiptSubTotalContainer extends StatelessWidget {
  final int subtotalNgn;

  const ReceiptSubTotalContainer({
    super.key,
    required this.subtotalNgn,
  });

  static const LinearGradient _gradient = LinearGradient(
    colors: [AppColours.penBlue, AppColours.teal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: _gradient,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Subtotal (NGN)',
            style: textTheme.titleSmall?.copyWith(
              color: AppColours.veryLightGrey,
            ),
          ),
          Text(
            formatCurrency(subtotalNgn),
            style: textTheme.titleSmall?.copyWith(
              color: AppColours.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
