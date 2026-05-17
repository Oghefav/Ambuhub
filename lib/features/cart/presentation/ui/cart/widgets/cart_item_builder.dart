import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:flutter/material.dart';
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

  Widget _singleItemBuilder(BuildContext context,) {
    final cartItem = cartItems.first;
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColours.veryLightVividTeal, width: 1),
        ),
      ),
      child: _buildRow(context, cartItem),
    );
  }

  Widget _multipleItemsBuilder(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColours.veryLightVividTeal, width: 1),
        ),
      ),
      child: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              _buildRow(context, cartItems[index]),
              if (index < cartItems.length - 1)
                const Divider(
                  color: AppColours.veryLightVividTeal,
                  height: 1,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRow(BuildContext context, CartItemEntity cartItem) {
    final textTheme = Theme.of(context).textTheme;
    final availableStock = cartItem.service.stock ?? 0;
    final isQuantityEqualOrLessThanStock = cartItem.quantity <= availableStock;
    return Padding(
      padding:  EdgeInsets.all(15.r),
      child: Column(
        spacing: 10.h,
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
                padding: EdgeInsets.all(10.w),
                child: Row(
                  spacing: 15.w,
                  children: [
                    IconButton(
                      onPressed: cartItem.quantity >= 1 ? () {} : null,
                      icon: const Icon(Icons.remove),
                    ),
                    Text('${cartItem.quantity}'),
                    IconButton(onPressed: isQuantityEqualOrLessThanStock ? () {} : null, icon: const Icon(Icons.add)),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColours.veryLightVividTeal,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.all(10.w),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(LucideIcons.trash, size: 20.sp),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
