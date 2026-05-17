import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:flutter/material.dart';
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
      actionsPadding: EdgeInsets.only(right: 15.w, top: 15.h),
    );
  }

  Widget shoppingCartIcon(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.cartScreen),
      child: const Column(
        children: [
          Icon(LucideIcons.shopping_cart, color: AppColours.veryLightGrey),
        ],
      ),
    );
  }
}
