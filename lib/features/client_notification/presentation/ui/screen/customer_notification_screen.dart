import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';
import 'package:ambuhub/core/widgets/client_app_scaffold.dart';
import 'package:flutter/material.dart';

class CustomerNotificationScreen extends StatelessWidget {
  const CustomerNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClientAppScaffold(
      body: EmptyContentPageBuilder(
        heading: 'Notifications',
        description: 'Alerts for orders, messages, and account activity.',
        placeholderText: 'Notifications placeholder.',
      ),
    );
  }
}