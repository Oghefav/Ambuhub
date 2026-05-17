import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';
import 'package:ambuhub/core/widgets/client_app_scaffold.dart';
import 'package:flutter/material.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClientAppScaffold(
      body: EmptyContentPageBuilder(
        heading: 'Profile',
        description: 'Your name, contact details, and account preferences.',
        placeholderText: 'Profile editor placeholder.',
      ),
    );
  }
}
