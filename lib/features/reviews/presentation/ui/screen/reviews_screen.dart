import 'package:ambuhub/core/widgets/client_app_scaffold.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/features/reviews/presentation/bloc/review/review_bloc.dart';
import 'package:ambuhub/features/reviews/presentation/bloc/review/review_event.dart';
import 'package:ambuhub/features/reviews/presentation/bloc/review/review_state.dart';
import 'package:ambuhub/features/reviews/presentation/ui/widget/awiating_review_builder.dart';
import 'package:ambuhub/features/reviews/presentation/ui/widget/reviews_view_orders_footer.dart';
import 'package:ambuhub/features/reviews/presentation/ui/widget/written_review_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ReviewBloc>();
    bloc
      ..add(const GetAwaitingReviews())
      ..add(const GetWrittenReviews());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ClientAppScaffold(
      body: BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, reviewState) {
          final pageError = reviewState.pageErrorMessage;

          return RefreshIndicator(
            onRefresh: () async {
              final bloc = context.read<ReviewBloc>();
              bloc
                ..add(const GetAwaitingReviews())
                ..add(const GetWrittenReviews());
              await bloc.stream.firstWhere(
                (s) => !s.isLoadingAwaiting && !s.isLoadingWritten,
              );
            },
            child: ListView(
              padding: EdgeInsets.all(16.r),
              children: [
                Text('Reviews', style: textTheme.displayLarge),
                SizedBox(height: 8.h),
                Text(
                  'Leave feedback for completed orders or read reviews you have written.',
                  style: textTheme.bodyMedium,
                ),
                if (pageError != null && pageError.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: ErrorMessageContainer(
                      addBorder: true,
                      errorMessage: pageError,
                    ),
                  ),
                ],
                SizedBox(height: 20.h),
                const AwiatingReviewBuilder(),
                SizedBox(height: 24.h),
                const WrittenReviewBuilder(),
                SizedBox(height: 30.h),
                const ReviewsViewOrdersFooter(),
              ],
            ),
          );
        },
      ),
    );
  }
}
