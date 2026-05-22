import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:ambuhub/features/reviews/domain/entities/awaiting_review.dart';
import 'package:ambuhub/features/reviews/domain/entities/write_review_params.dart';
import 'package:ambuhub/features/reviews/presentation/bloc/review/review_bloc.dart';
import 'package:ambuhub/features/reviews/presentation/bloc/review/review_event.dart';
import 'package:ambuhub/features/reviews/presentation/bloc/review/review_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String _awaitingReviewCardKey(AwaitingReviewEntity item) =>
    '${item.orderId}_${item.serviceId}';

class AwiatingReviewBuilder extends HookWidget {
  const AwiatingReviewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final expandedCardKey = useState<String?>(null);

    void collapseExpanded() => expandedCardKey.value = null;

    void toggleExpanded(String cardKey) {
      expandedCardKey.value =
          expandedCardKey.value == cardKey ? null : cardKey;
    }

    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        final sectionTitle = Text(
          'Awaiting your review',
          style: textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        );

        if (state.isLoadingAwaiting && state.awaitingReviews.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              sectionTitle,
              Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: const Center(child: CupertinoActivityIndicator()),
              ),
            ],
          );
        }

        if (state.awaitingReviews.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              sectionTitle,
              DottedBorderContainer(
                borderColor: AppColours.hireCyanIce,
                color: AppColours.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 28.h,
                  ),
                  child: Text(
                    'Nothing to review right now. After you buy or complete a hire, eligible listings will appear here and on your receipt.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColours.grey,
                      fontSize: 11.sp,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            sectionTitle,
            ...state.awaitingReviews.map(
              (item) {
                final cardKey = _awaitingReviewCardKey(item);
                return _AwaitingReviewCard(
                  key: ValueKey(cardKey),
                  item: item,
                  isExpanded: expandedCardKey.value == cardKey,
                  onToggleExpanded: () => toggleExpanded(cardKey),
                  onCollapse: collapseExpanded,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _AwaitingReviewCard extends HookWidget {
  final AwaitingReviewEntity item;
  final bool isExpanded;
  final VoidCallback onToggleExpanded;
  final VoidCallback onCollapse;

  const _AwaitingReviewCard({
    super.key,
    required this.item,
    required this.isExpanded,
    required this.onToggleExpanded,
    required this.onCollapse,
  });

  static const int _minChars = 10;
  static const int _maxChars = 2000;
  static const Color _starFilled = Color.fromRGBO(255, 187, 0, 1);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final rating = useState(0);
    final validationError = useState<String?>(null);
    final apiError = useState<String?>(null);
    final reviewController = useTextEditingController();
    useListenable(reviewController);

    useEffect(() {
      if (!isExpanded) {
        rating.value = 0;
        validationError.value = null;
        apiError.value = null;
        reviewController.clear();
      }
      return null;
    }, [isExpanded]);

    void resetForm() {
      rating.value = 0;
      validationError.value = null;
      apiError.value = null;
      reviewController.clear();
    }

    void collapse() {
      resetForm();
      onCollapse();
    }

    String? validate() {
      if (rating.value < 1) return 'Please select a star rating.';
      final text = reviewController.text.trim();
      if (text.length < _minChars) {
        return 'Review must be at least $_minChars characters.';
      }
      if (text.length > _maxChars) {
        return 'Review must be at most $_maxChars characters.';
      }
      return null;
    }

    void submit() {
      final error = validate();
      if (error != null) {
        validationError.value = error;
        apiError.value = null;
        return;
      }

      validationError.value = null;
      apiError.value = null;

      context.read<ReviewBloc>().add(
            WriteReview(
              params: WriteReviewParams(
                orderId: item.orderId,
                serviceId: item.serviceId,
                rating: rating.value,
                body: reviewController.text.trim(),
              ),
            ),
          );
    }

    return BlocListener<ReviewBloc, ReviewState>(
      listenWhen: (previous, current) {
        final wasPending = previous.isSubmittingReviewFor(
          item.orderId,
          item.serviceId,
        );
        final isPending = current.isSubmittingReviewFor(
          item.orderId,
          item.serviceId,
        );
        return wasPending && !isPending;
      },
      listener: (context, state) {
        if (state.hasWriteErrorFor(item.orderId, item.serviceId)) {
          apiError.value = state.writeReviewErrorMessage;
          return;
        }
        if (!state.isWritingReview) {
          collapse();
        }
      },
      child: BlocBuilder<ReviewBloc, ReviewState>(
        buildWhen: (previous, current) =>
            previous.isWritingReview != current.isWritingReview ||
            previous.pendingWriteOrderId != current.pendingWriteOrderId ||
            previous.pendingWriteServiceId != current.pendingWriteServiceId,
        builder: (context, state) {
          final isSubmitting = state.isSubmittingReviewFor(
            item.orderId,
            item.serviceId,
          );
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: AppColours.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColours.hireCyanIce),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                Text(
                  item.serviceTitle,
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColours.hirePurpleDeep,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Receipt order ${item.receiptNumber} · ${item.lineKind}',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColours.grey,
                    fontSize: 10.sp,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _ActionChip(
                    label: isExpanded ? 'Close' : 'Write review',
                    filled: true,
                    onTap: onToggleExpanded,
                  ),
                ),
                if (isExpanded) ...[
                  const Divider(
                    color: AppColours.hireCyanIce,
                    thickness: 1,
                    height: 1,
                  ),
                  _StarRatingRow(
                    rating: rating.value,
                    filledColor: _starFilled,
                    outlineColor: AppColours.veryLightVividTeal,
                    onRatingChanged: (value) {
                      rating.value = value;
                      validationError.value = null;
                    },
                  ),
                  Text(
                    'Your review',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColours.hirePurpleDeep,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                    ),
                  ),
                  TextFormField(
                    controller: reviewController,
                    minLines: 4,
                    maxLines: 6,
                    maxLength: _maxChars,
                    buildCounter: (
                      context, {
                      required currentLength,
                      required isFocused,
                      maxLength,
                    }) =>
                        const SizedBox.shrink(),
                    decoration: InputDecoration(
                      hintText:
                          'Share what went well or what could improve (min. 10 characters).',
                      hintStyle: textTheme.bodySmall?.copyWith(
                        color: AppColours.grey,
                        fontSize: 10.sp,
                      ),
                      filled: true,
                      fillColor: AppColours.white,
                      contentPadding: EdgeInsets.all(10.r),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide:
                            const BorderSide(color: AppColours.hireCyanIce),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide:
                            const BorderSide(color: AppColours.hireCyanIce),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: AppColours.vividTeal,
                          width: 1.5.w,
                        ),
                      ),
                    ),
                    style: textTheme.bodySmall?.copyWith(fontSize: 10.sp),
                  ),
                  Text(
                    '${reviewController.text.length} / $_maxChars',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColours.grey,
                      fontSize: 9.sp,
                    ),
                  ),
                  if (validationError.value != null || apiError.value != null)
                    Text(
                      validationError.value ?? apiError.value!,
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.red,
                        fontSize: 10.sp,
                      ),
                    ),
                  Row(
                    spacing: 8.w,
                    children: [
                      _ActionChip(
                        label: 'Submit review',
                        filled: true,
                        isLoading: isSubmitting,
                        onTap: isSubmitting ? null : submit,
                      ),
                      _ActionChip(
                        label: 'Cancel',
                        filled: false,
                        onTap: isSubmitting ? null : collapse,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final String label;
  final bool filled;
  final bool isLoading;
  final VoidCallback? onTap;

  const _ActionChip({
    required this.label,
    required this.filled,
    this.isLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final enabled = onTap != null && !isLoading;

    final bgColor = !enabled && filled
        ? AppColours.vividTeal.withValues(alpha: 0.45)
        : filled
            ? AppColours.vividTeal
            : AppColours.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: filled ? AppColours.vividTeal : AppColours.hireCyanIce,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6.w,
          children: [
            if (isLoading) ...[
              SizedBox(
                width: 14.sp,
                height: 14.sp,
                child: CupertinoActivityIndicator(
                  radius: 7.sp,
                  color: filled ? AppColours.white : AppColours.vividTeal,
                ),
              ),
            ],
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: filled ? AppColours.white : AppColours.vividTeal,
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StarRatingRow extends StatelessWidget {
  final int rating;
  final Color filledColor;
  final Color outlineColor;
  final ValueChanged<int> onRatingChanged;

  const _StarRatingRow({
    required this.rating,
    required this.filledColor,
    required this.outlineColor,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4.w,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isFilled = starIndex <= rating;
        return GestureDetector(
          onTap: () => onRatingChanged(starIndex),
          child: Icon(
            isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
            color: isFilled ? filledColor : outlineColor,
            size: 28.sp,
          ),
        );
      }),
    );
  }
}
