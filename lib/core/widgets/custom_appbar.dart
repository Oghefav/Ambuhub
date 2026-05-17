import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SliverAppBar(
      leading: IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: const Icon(Icons.menu, color: AppColours.veryLightGrey),
      ),
      title: Text(
        'Provider',
        style: textTheme.titleSmall!.copyWith(color: AppColours.veryLightGrey),
      ),
      titleTextStyle: textTheme.titleMedium,
    );
  }
}
