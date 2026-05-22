import 'package:ambuhub/features/reviews/presentation/bloc/review/review_bloc.dart';
import 'package:ambuhub/features/reviews/presentation/bloc/review/review_state.dart';
import 'package:ambuhub/features/reviews/presentation/ui/widget/written_review_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WrittenReviewBuilder extends StatelessWidget {
  const WrittenReviewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              "Reviews you've written",
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (state.isLoadingWritten && state.writtenReviews.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Center(child: CupertinoActivityIndicator()),
              )
            else if (state.writtenReviews.isEmpty)
              Text(
                'You have not submitted any reviews yet.',
                style: textTheme.bodySmall,
              )
            else
              ...state.writtenReviews.map(
                (review) => WrittenReviewCard(
                  key: ValueKey(review.id),
                  review: review,
                ),
              ),
          ],
        );
      },
    );
  }
}
