import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: Icon(Icons.menu),
      ),
      title: Text('Provider'),
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
    );
  }
}
