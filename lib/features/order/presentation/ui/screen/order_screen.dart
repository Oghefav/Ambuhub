import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';
import 'package:ambuhub/core/widgets/client_app_scaffold.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClientAppScaffold(
      body: EmptyContentPageBuilder(
        heading: 'Orders',
        description: 'Purchases and bookings you have made on Ambuhub.',
        placeholderText: 'Order history placeholder.',
      ),
    );
  }
}
