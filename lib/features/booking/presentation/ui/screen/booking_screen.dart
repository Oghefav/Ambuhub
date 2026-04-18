import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CustomScrollView(
        slivers: [
          CustomAppbar(),
      
          SliverToBoxAdapter(
            child: EmptyContentPageBuilder(
              heading: 'Bookings',
              description:
                  'Confirmed and pending requests from organizers-events, transports, and staffing. Calendar sync will be added later.',
              placeholderText: 'No bookings to show yet',
            ),
          ),
        ],
      ),
    );
  }
}
