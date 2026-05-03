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
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.h),
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: cardNumber == 1 || cardNumber == 3
              ? [
                  AppColours.teal,
                  Color.fromRGBO(28, 59, 153, 1.0),
                  Color.fromRGBO(28, 59, 153, 1.0),
                  AppColours.teal,
                ]
              : cardNumber == 2
              ? [
                  Color.fromRGBO(28, 59, 153, 1.0),
                  Color.fromRGBO(28, 59, 153, 1.0),
                  Color.fromRGBO(28, 59, 153, 1.0),
                  AppColours.teal,
                ]
              : [
                  Color.fromRGBO(47, 50, 145, 1.0),
                  Color.fromRGBO(28, 59, 153, 1.0),
                  Color.fromRGBO(47, 50, 145, 1.0),
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
                BoxShadow(
                  color: AppColours.teal,
                  blurRadius: 10,
                  spreadRadius: -5,
                  offset: Offset(0, 10),
                ),
              ]
            : cardNumber == 2
            ? [
                BoxShadow(
                  color: AppColours.penBlue,
                  blurRadius: 10,
                  spreadRadius: -5,
                  offset: Offset(0, 10),
                ),
              ]
            : [
                BoxShadow(
                  color: Color.fromRGBO(28, 59, 153, 1.0),
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
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight(600),
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
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(color: AppColours.white),
                    ),
                  ],
                )
              : Text(
                  numberValue.toString(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    // fontSize: secondTextFontSize ?? 14.sp,
                    color: AppColours.white,
                  ),
                ),
          SizedBox(height: 5.h),
          Text(
            secondText,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColours.veryLightGrey,
              fontWeight: FontWeight(600),
              fontSize: secondTextFontSize ?? 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
