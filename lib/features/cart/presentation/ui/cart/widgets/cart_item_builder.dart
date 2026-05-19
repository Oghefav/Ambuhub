import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemsBuilder extends StatelessWidget {
  final List<CartItemEntity> cartItems;
  const CartItemsBuilder({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final length = cartItems.length;
    if (length == 1) {
      return _singleItemBuilder(context);
    } else {
      return _multipleItemsBuilder(context);
    }
  }

  Widget _singleItemBuilder(BuildContext context) {
    final cartItem = cartItems.first;
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColours.veryLightVividTeal, width: 1.5.w),
      ),
      child: _buildRow(context, cartItem),
    );
  }

  Widget _multipleItemsBuilder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColours.veryLightVividTeal, width: 1.5.w),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var index = 0; index < cartItems.length; index++) ...[
            _buildRow(context, cartItems[index]),
            if (index < cartItems.length - 1)
              Divider(
                color: AppColours.veryLightVividTeal,
                height: 1.w,
                thickness: 1.5.w,
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, CartItemEntity cartItem) {
    final textTheme = Theme.of(context).textTheme;
    final availableStock = cartItem.service.stock ?? 0;
    final isQuantityEqualOrLessThanStock = cartItem.quantity <= availableStock;
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              Text(cartItem.service.title, style: textTheme.titleSmall),
              Text(
                '${cartItem.service.serviceCategory} · ${cartItem.service.dept}',
                style: textTheme.bodySmall,
              ),
              Text(
                '${formatCurrency(cartItem.service.price.toString())} each',
                style: textTheme.titleSmall,
              ),
              Row(
                spacing: 8.w,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColours.veryLightVividTeal,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      spacing: 15.w,
                      children: [
                        GestureDetector(
                          onTap:
                              cartItem.quantity >= 1 && (state is! CartLoading)
                              ? () {
                                  print('Decrementing cart item');
                                  context.read<CartBloc>().add(
                                    CartItemDecrement(item: cartItem),
                                  );
                                }
                              : null,
                          child: Icon(
                            Icons.remove,
                            size: 15.sp,
                            color:
                                cartItem.quantity <= 1 || state is CartLoading
                                ? AppColours.veryLightGrey
                                : AppColours.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text('${cartItem.quantity}'),
                        GestureDetector(
                          onTap:
                              isQuantityEqualOrLessThanStock &&
                                  (state is! CartLoading)
                              ? () => context.read<CartBloc>().add(
                                  CartItemIncrement(item: cartItem),
                                )
                              : null,
                          child: Icon(
                            Icons.add,
                            size: 15.sp,
                            color:
                                cartItem.quantity == availableStock ||
                                    state is CartLoading
                                ? AppColours.veryLightGrey
                                : AppColours.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColours.veryLightVividTeal,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 8.h,
                    ),
                    child: GestureDetector(
                      onTap: state is CartLoading
                          ? null
                          : () => context.read<CartBloc>().add(
                              RemoveCartItem(item: cartItem),
                            ),
                      child: Icon(
                        LucideIcons.trash,
                        size: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColours.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
