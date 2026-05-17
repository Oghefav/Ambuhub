import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';
import 'package:ambuhub/core/widgets/client_app_scaffold.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClientAppScaffold(
      body: EmptyContentPageBuilder(
        heading: 'Reviews',
        description: 'Ratings and feedback you have left for providers.',
        placeholderText: 'Reviews placeholder.',
      ),
    );
  }
}
