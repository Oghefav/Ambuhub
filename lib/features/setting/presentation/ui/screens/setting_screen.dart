import 'package:ambuhub/core/widgets/provider_app_scaffold.dart';
import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderAppScaffold(
      body: CustomScrollView(
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
