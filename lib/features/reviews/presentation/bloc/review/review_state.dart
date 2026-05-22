import 'package:ambuhub/features/reviews/domain/entities/awaiting_review.dart';
import 'package:ambuhub/features/reviews/domain/entities/written_review.dart';
import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {
  final List<AwaitingReviewEntity> awaitingReviews;
  final List<WrittenReviewEntity> writtenReviews;
  final WrittenReviewEntity? selectedReview;
  final String? errorMessage;
  final String? writeReviewErrorMessage;
  final String? writeReviewErrorOrderId;
  final String? writeReviewErrorServiceId;
  final bool hasLoadedAwaiting;
  final bool hasLoadedWritten;
  final bool isLoadingAwaiting;
  final bool isLoadingWritten;
  final bool isLoadingDetail;
  final bool isWritingReview;
  final String? lastWrittenReviewId;
  final String? pendingWriteOrderId;
  final String? pendingWriteServiceId;

  const ReviewState({
    this.awaitingReviews = const [],
    this.writtenReviews = const [],
    this.selectedReview,
    this.errorMessage,
    this.writeReviewErrorMessage,
    this.writeReviewErrorOrderId,
    this.writeReviewErrorServiceId,
    this.hasLoadedAwaiting = false,
    this.hasLoadedWritten = false,
    this.isLoadingAwaiting = false,
    this.isLoadingWritten = false,
    this.isLoadingDetail = false,
    this.isWritingReview = false,
    this.lastWrittenReviewId,
    this.pendingWriteOrderId,
    this.pendingWriteServiceId,
  });

  bool isSubmittingReviewFor(String orderId, String serviceId) {
    return isWritingReview &&
        pendingWriteOrderId == orderId &&
        pendingWriteServiceId == serviceId;
  }

  bool hasWriteErrorFor(String orderId, String serviceId) {
    return writeReviewErrorMessage != null &&
        writeReviewErrorOrderId == orderId &&
        writeReviewErrorServiceId == serviceId;
  }

  String? get pageErrorMessage {
    if (this is ReviewFailure) {
      return (this as ReviewFailure).errorMessage;
    }
    return errorMessage;
  }

  @override
  List<Object?> get props => [
        awaitingReviews,
        writtenReviews,
        selectedReview,
        errorMessage,
        writeReviewErrorMessage,
        writeReviewErrorOrderId,
        writeReviewErrorServiceId,
        hasLoadedAwaiting,
        hasLoadedWritten,
        isLoadingAwaiting,
        isLoadingWritten,
        isLoadingDetail,
        isWritingReview,
        lastWrittenReviewId,
        pendingWriteOrderId,
        pendingWriteServiceId,
      ];
}

class ReviewInitial extends ReviewState {
  const ReviewInitial();
}

class ReviewLoaded extends ReviewState {
  const ReviewLoaded({
    super.awaitingReviews,
    super.writtenReviews,
    super.selectedReview,
    super.errorMessage,
    super.writeReviewErrorMessage,
    super.writeReviewErrorOrderId,
    super.writeReviewErrorServiceId,
    super.hasLoadedAwaiting = false,
    super.hasLoadedWritten = false,
    super.isLoadingAwaiting = false,
    super.isLoadingWritten = false,
    super.isLoadingDetail = false,
    super.isWritingReview = false,
    super.lastWrittenReviewId,
    super.pendingWriteOrderId,
    super.pendingWriteServiceId,
  });
}

class ReviewFailure extends ReviewState {
  const ReviewFailure({
    required super.errorMessage,
    super.awaitingReviews,
    super.writtenReviews,
    super.selectedReview,
    super.hasLoadedAwaiting,
    super.hasLoadedWritten,
    super.isLoadingAwaiting = false,
    super.isLoadingWritten = false,
    super.isLoadingDetail = false,
    super.isWritingReview = false,
    super.lastWrittenReviewId,
  });
}
