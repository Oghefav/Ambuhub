import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CustomScrollView(
          slivers: [
            CustomAppbar(),
            SliverToBoxAdapter(
              child: EmptyContentPageBuilder(
                heading: 'Settings',
                description:
                    'Notifications, payout preferences, and account security will live here',
                placeholderText: 'Settings placeholder.',
              ),
            ),
          ],
        
      ),
    );
  }
}
