import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: Icon(Icons.menu, color: AppColours.veryLightGrey),
      ),
      title: Text(
        'Provider',
        style: Theme.of(
          context,
        ).textTheme.titleSmall!.copyWith(color: AppColours.veryLightGrey),
      ),
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
    );
  }
}
