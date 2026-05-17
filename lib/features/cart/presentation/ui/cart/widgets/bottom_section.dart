import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final totalPrice = state.cart?.totalPrice ?? 0;
        return Container(
          padding: EdgeInsets.all(15.w),
          child: Column(
                children: [
                  Text(
                    'Total (NGN)',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    formatCurrency(totalPrice.toString()),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  _paymentButton(context),
                ],
              ),
        );
      },
    );
  }

  Widget _paymentButton(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColours.vividTeal,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocSelector<CartBloc, CartState, bool>(
                selector: (state) => state is CartLoading,
                builder: (context, isPaymentLoading) {
                  return isPaymentLoading
                      ? const CupertinoActivityIndicator()
                      : const SizedBox.shrink();
                },
              ),
              Text('Pay with Paystck (simuated)', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColours.white)),
            ],
          ),
        ),
      ),
    );
  }
}
