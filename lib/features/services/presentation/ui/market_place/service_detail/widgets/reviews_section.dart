import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/reviews/domain/entities/service_reviews.dart';
import 'package:ambuhub/features/reviews/presentation/ui/widget/written_review_card.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/shadow_container_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsSection extends StatelessWidget {
  final ServiceReviewsEntity serviceReviews;

  const ReviewsSection({
    super.key,
    required this.serviceReviews,
  });

  static const Color _starFilled = Color.fromRGBO(255, 187, 0, 1);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final reviews = serviceReviews.reviews;

    return ShadowContainerTemplate(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            'Reviews',
            style: textTheme.titleSmall?.copyWith(
              color: AppColours.darkVividTeal,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (!serviceReviews.hasDisplayableReviews) ...[
            Text(
              'No reviews yet. Verified buyers and hirers can leave the first review after completing a purchase or hire.',
              style: textTheme.bodySmall?.copyWith(
                color: AppColours.grey,
                height: 1.4,
                fontSize: 11.sp,
              ),
            ),
          ] else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_rounded,
                  color: _starFilled,
                  size: 18.sp,
                ),
                
                Text(
                  serviceReviews.displayAverageRating.toStringAsFixed(1),
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColours.hirePurpleDeep,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  _reviewCountLabel(serviceReviews.displayReviewCount),
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColours.grey,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
            ...reviews.map(
              (review) => WrittenReviewCard(
                key: ValueKey(review.id),
                review: review,
                style: WrittenReviewCardStyle.serviceListing,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _reviewCountLabel(int count) {
    if (count == 1) return '(1 review)';
    return '($count reviews)';
  }
}
