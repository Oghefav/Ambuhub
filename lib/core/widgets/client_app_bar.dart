import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientAppBar extends StatelessWidget {
  const ClientAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      leading: IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: const Icon(Icons.menu, color: AppColours.veryLightGrey),
      ),
      title: Text(
        'Client',
        style: textTheme.titleSmall!.copyWith(color: AppColours.veryLightGrey),
      ),
      titleTextStyle: textTheme.titleMedium,
      actions: [shoppingCartIcon(context)],
      actionsPadding: EdgeInsets.only(right: 20.w, bottom: 15.h),
    );
  }

  Widget shoppingCartIcon(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        BlocProvider.of<NavigationCubit>(context).setPage('');
        Navigator.pushNamed(context, AppRoutes.cartScreen);
      },
      child: SizedBox(
        width: 35.w,
        height: 40.h,
        child: Stack(
          children: [
            const Positioned(
              bottom: 0,
              child: Icon(
                LucideIcons.shopping_cart,
                color: AppColours.veryLightGrey,
              ),
            ),
            BlocSelector<CartBloc, CartState, int>(
              selector: (state) => state.totalItemCount,
              builder: (context, count) => count > 0
                  ? Positioned(
                      right: 2.w,
                      top: 0,
                      child: Container(
                              padding: EdgeInsets.all(5.w),
                              decoration: const BoxDecoration(
                                color: AppColours.vividTeal,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                count.toString(),
                                style: textTheme.bodySmall!.copyWith(
                                  color: AppColours.white,
                                ),
                              ),
                            ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
