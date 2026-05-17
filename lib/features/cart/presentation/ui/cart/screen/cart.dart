import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/widgets/client_app_scaffold.dart';
import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:ambuhub/features/cart/presentation/ui/cart/widgets/cart_item_builder.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/widgets/error_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ClientAppScaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is CartSuccess) {
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Checkout', style: textTheme.displayLarge),
                  SizedBox(height: 15.h),
                  Text('Paystack is not connected yet. Completing payment runs a temporary simulation only.', style: textTheme.bodyMedium),
                  SizedBox(height: 25.h),
                  CartItemsBuilder(cartItems: state.cart!.items),
                ],
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
    );
  }
}
