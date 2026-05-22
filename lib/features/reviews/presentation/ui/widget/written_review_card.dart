import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/reviews/domain/entities/written_review.dart';
import 'package:ambuhub/features/reviews/presentation/ui/widget/review_stars_row.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/service_detail/market_place_service_detail_args.dart'
    show MarketPlaceServiceDetailArgs, ServiceDetailReturnTarget;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum WrittenReviewCardStyle {
  myReviews,
  serviceListing,
}

class WrittenReviewCard extends StatelessWidget {
  final WrittenReviewEntity review;
  final WrittenReviewCardStyle style;

  const WrittenReviewCard({
    super.key,
    required this.review,
    this.style = WrittenReviewCardStyle.myReviews,
  });

  static const Color starFilled = Color.fromRGBO(255, 187, 0, 1);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final submittedAt = style == WrittenReviewCardStyle.serviceListing
        ? formatReviewDateOrNull(review.createdAt)
        : formatReviewDateTimeOrNull(review.createdAt);

    final cardBody = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        if (style == WrittenReviewCardStyle.serviceListing)
          _buildReviewerHeader(textTheme, submittedAt)
        else
          _buildServiceTitleHeader(context, textTheme, submittedAt),
        ReviewStarsRow(
          rating: review.rating,
          filledColor: starFilled,
          outlineColor: AppColours.veryLightVividTeal,
        ),
        Text(
          review.body,
          style: textTheme.bodySmall?.copyWith(
            fontSize: style == WrittenReviewCardStyle.serviceListing ? 10.sp : 12.sp,
            height: 1.4,
          ),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColours.hireCyanIce),
      ),
      child: cardBody,
    );
  }

  Widget _buildReviewerHeader(TextTheme textTheme, String? submittedAt) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            review.reviewerDisplayName.isNotEmpty
                ? review.reviewerDisplayName
                : 'Verified buyer',
            style: textTheme.titleSmall?.copyWith(
              color: AppColours.hirePurpleDeep,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (submittedAt != null)
          Text(
            submittedAt,
            style: textTheme.bodySmall?.copyWith(
              color: AppColours.grey,
              fontSize: 10.sp,
            ),
          ),
      ],
    );
  }

  Widget _buildServiceTitleHeader(
    BuildContext context,
    TextTheme textTheme,
    String? submittedAt,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.marketPlaceServiceDetailScreen,
              arguments: MarketPlaceServiceDetailArgs(
                serviceId: review.serviceId,
                returnTarget: ServiceDetailReturnTarget.reviews,
              ),
            );
          },
          child: Text(
            review.serviceTitle,
            style: textTheme.titleSmall?.copyWith(
              color: AppColours.vividTeal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (submittedAt != null)
          Text(
            submittedAt,
            style: textTheme.bodySmall?.copyWith(
              color: AppColours.grey,
              fontSize: 10.sp,
            ),
          ),
      ],
    );
  }
}
