import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardBuilder extends StatelessWidget {
  final String firstText;
  final String secondText;
  final double? secondTextFontSize;
  final String? amountValue;
  final int cardNumber;
  final int? numberValue;
  final bool isWalletBalance;
  const CardBuilder({
    super.key,
    required this.firstText,
    required this.secondText,
    this.secondTextFontSize,
    this.isWalletBalance = false,
    this.numberValue,
    this.amountValue,
    required this.cardNumber,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.h),
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: cardNumber == 1 || cardNumber == 3
              ? [
                  AppColours.teal,
                  AppColours.penBlue,
                  AppColours.penBlue,
                  AppColours.teal,
                ]
              : cardNumber == 2
              ? [
                  AppColours.penBlue,
                  AppColours.penBlue,
                  AppColours.penBlue,
                  AppColours.teal,
                ]
              : [
                  AppColours.royalIndigo,
                  AppColours.penBlue,
                  AppColours.royalIndigo,
                ],
          stops: cardNumber == 1 || cardNumber == 3
              ? [0.0, 0.2, 0.8, 1.0]
              : cardNumber == 2
              ? [0.0, 0.2, 0.8, 1.0]
              : [0.0, 0.5, 1.0],
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
        ),
        borderRadius: BorderRadiusGeometry.circular(15.r),
        boxShadow: cardNumber == 1 || cardNumber == 3
            ? [
                const BoxShadow(
                  color: AppColours.teal,
                  blurRadius: 10,
                  spreadRadius: -5,
                  offset: Offset(0, 10),
                ),
              ]
            : cardNumber == 2
            ? [
                const BoxShadow(
                  color: AppColours.penBlue,
                  blurRadius: 10,
                  spreadRadius: -5,
                  offset: Offset(0, 10),
                ),
              ]
            : [
                const BoxShadow(
                  color: AppColours.penBlue,
                  blurRadius: 10,
                  spreadRadius: -5,
                  offset: Offset(0, 10),
                ),
              ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            firstText,
            style: textTheme.titleMedium!.copyWith(
              fontWeight: const FontWeight(600),
              fontSize: 14.sp,
              color: AppColours.veryLightGrey,
            ),
          ),
          SizedBox(height: 5.h),
          isWalletBalance
              ? Row(
                  children: [
                    Icon(
                      LucideIcons.wallet,
                      size: 20.sp,
                      color: AppColours.veryLightGrey,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      formatCurrency(amountValue),
                      style: textTheme.titleLarge!.copyWith(color: AppColours.white),
                    ),
                  ],
                )
              : Text(
                  numberValue.toString(),
                  style: textTheme.titleLarge!.copyWith(
                    // fontSize: secondTextFontSize ?? 14.sp,
                    color: AppColours.white,
                  ),
                ),
          SizedBox(height: 5.h),
          Text(
            secondText,
            style: textTheme.titleMedium!.copyWith(
              color: AppColours.veryLightGrey,
              fontWeight: const FontWeight(600),
              fontSize: secondTextFontSize ?? 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
