import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/widgets/client_app_scaffold.dart';
import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:ambuhub/features/cart/presentation/ui/cart/widgets/bottom_section.dart';
import 'package:ambuhub/features/cart/presentation/ui/cart/widgets/cart_item_builder.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_bloc.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_state.dart';
import 'package:ambuhub/features/order/presentation/ui/order_receipt_args.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/widgets/error_widget.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderCreated) {
          context.read<CartBloc>().add(const ClearCart());
          Navigator.pushNamed(
            context,
            AppRoutes.orderReceiptScreen,
            arguments: OrderReceiptArgs.fromOrder(state.order!),
          );
        }
        if (state is OrderCreatedFailure) {
          showCustomFlushBar(
            context,
            message: state.errorMessage ?? 'Checkout failed',
            title: 'Error',
            type: AppFlushBarType.error,
          );
        }
      },
      child: ClientAppScaffold(
      backgroundColor: AppColours.white,
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading && state.pendingServiceId == null) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is CartSuccess ||
              (state is CartFailure && state.cart != null) ||
              (state is CartLoading && state.pendingServiceId != null)) {
            if (state.cart?.items.isEmpty ?? true) {
              return EmptyContentPageBuilder(
                heading: 'Checkout',
                description:
                    'Paystack is not connected yet. Completing payment runs a temporary simulation only.',
                navigationText: 'Browse services',
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.clientDashBoardScreen,
                ),
                placeholderText: 'Your cart is empty',
              );
            } else {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Checkout', style: textTheme.displayLarge),
                    SizedBox(height: 15.h),
                    Text(
                      'Paystack is not connected yet. Completing payment runs a temporary simulation only.',
                      style: textTheme.bodyMedium,
                    ),
                    if (state is CartFailure)
                      Padding(
                        padding: EdgeInsets.only(top: 15.h),
                        child: ErrorMessageContainer(
                          addBorder: true,
                          errorMessage:
                              state.errorMessage ?? 'Failed to load cart',
                        ),
                      ),
                    SizedBox(height: 25.h),
                    CartItemsBuilder(cartItems: state.cart!.items),
                    SizedBox(height: 20.h),
                    const BottomSection(),
                  ],
                ),
              );
            }
          }
          return Center(
            child: ErrorSection(
              onPressed: () => context.read<CartBloc>().add(const GetCart()),
              errorMessage: 'Failed to load cart',
            ),
          );
        },
      ),
      ),
    );
  }
}
