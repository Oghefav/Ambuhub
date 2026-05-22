import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:ambuhub/features/order/presentation/ui/widget/order_items_builder.dart';
import 'package:ambuhub/features/order/presentation/ui/widget/orders_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersListBuilder extends StatelessWidget {
  final List<OrderEntity> orders;
  final String description;

  const OrdersListBuilder({
    super.key,
    required this.orders,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 20.h),
      itemCount: orders.length + 1,
      separatorBuilder: (_, __) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: OrdersHeader(description: description),
          );
        }
        return OrderItemsBuilder(order: orders[index - 1]);
      },
    );
  }
}
