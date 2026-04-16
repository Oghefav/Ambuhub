import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppbar(),
          SliverToBoxAdapter(
            child: EmptyContentPageBuilder(
              heading: 'Business profile',
              description:
                  'Company name, licenses, service areas, and verification documents shown to customers on your listings.',
              placeholderText: 'Profile editor placeholder.',
            ),
          ),
        ],
      ),
    );
  }
}
