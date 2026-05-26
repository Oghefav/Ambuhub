import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_bloc.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_event.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_state.dart';
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
          decoration: BoxDecoration(
            color: AppColours.lighterTeal,
            border: Border.all(color: AppColours.veryLightVividTeal, width: 1.5.w),
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.h,
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
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, orderState) {
        final isLoading = orderState is OrderLoading;
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : () => BlocProvider.of<OrderBloc>(context).add(const CheckoutCart()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColours.vividTeal,
              disabledBackgroundColor:
                  AppColours.vividTeal.withValues(alpha: 0.55),
              disabledForegroundColor: AppColours.white,
              foregroundColor: AppColours.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading) ...[
                  const CupertinoActivityIndicator(color: AppColours.white),
                  SizedBox(width: 8.w),
                ],
                Text(
                  'Pay with Paystck (simuated)',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColours.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
