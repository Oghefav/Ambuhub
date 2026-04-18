import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';
import 'package:flutter/material.dart';

class AvailabilityScreen extends StatelessWidget {
  
  const AvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CustomScrollView(
          slivers: [
            CustomAppbar(),
            SliverToBoxAdapter(
              child: EmptyContentPageBuilder(
                heading: 'Availability',
                description:
                    'Block out dates for event standby, tours, and shift coverage so buyers only see slots you can honor',
                placeholderText: 'Availability calendar placeholder.',
              ),
            ),
          ],
        
      ),
    );
  }
}
