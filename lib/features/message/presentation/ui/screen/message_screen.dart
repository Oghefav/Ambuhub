import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CustomScrollView(
          slivers: [
            CustomAppbar(),
            SliverToBoxAdapter(
              child: EmptyContentPageBuilder(
                heading: 'Messages',
                description:
                    'Conversations with organizers and buyers about quotes and booking details.',
                placeholderText: 'inbox placeholder.',
              ),
            ),
          ],
        
      ),
    );
  }
}
