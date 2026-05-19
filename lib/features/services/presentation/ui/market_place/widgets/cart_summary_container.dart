import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartSummaryContainer extends StatelessWidget {
  const CartSummaryContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cart = state.cart;
        if (cart == null || cart.items.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        return SliverToBoxAdapter(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColours.verylightTeal,
          border: Border.all(color: AppColours.veryLightVividTeal, width: 1.w),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5.h,
                children: [
                  Text(
                    'Your cart',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, fontSize: 11.sp),
                  ),
                  Text(
                    '${state.totalItemCount} items · ${formatCurrency(cart.totalPrice)}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRoutes.cartScreen),
                child: Container(
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                    color: AppColours.vividTeal,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    'Checkout',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: AppColours.white, fontWeight: FontWeight.w600, fontSize: 11.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
          ),
        );
      },
    );
  }
}
