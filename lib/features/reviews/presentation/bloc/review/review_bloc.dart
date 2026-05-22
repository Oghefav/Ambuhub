import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/reviews/domain/usecases/get_awaiting_reviews.dart';
import 'package:ambuhub/features/reviews/domain/usecases/get_review_by_id.dart';
import 'package:ambuhub/features/reviews/domain/usecases/get_written_reviews.dart';
import 'package:ambuhub/features/reviews/domain/usecases/write_review.dart';
import 'package:ambuhub/features/reviews/presentation/bloc/review/review_event.dart';
import 'package:ambuhub/features/reviews/presentation/bloc/review/review_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final GetAwaitingReviewsUsecase _getAwaitingReviewsUsecase;
  final GetWrittenReviewsUsecase _getWrittenReviewsUsecase;
  final WriteReviewUsecase _writeReviewUsecase;
  final GetReviewByIdUsecase _getReviewByIdUsecase;

  ReviewBloc(
    this._getAwaitingReviewsUsecase,
    this._getWrittenReviewsUsecase,
    this._writeReviewUsecase,
    this._getReviewByIdUsecase,
  ) : super(const ReviewInitial()) {
    on<GetAwaitingReviews>(_onGetAwaitingReviews);
    on<GetWrittenReviews>(_onGetWrittenReviews);
    on<WriteReview>(_onWriteReview);
    on<GetReviewById>(_onGetReviewById);
    on<ReviewReset>(_onReviewReset);
  }

  void _onReviewReset(ReviewReset event, Emitter<ReviewState> emit) {
    emit(const ReviewInitial());
  }

  Future<void> _onGetAwaitingReviews(
    GetAwaitingReviews event,
    Emitter<ReviewState> emit,
  ) async {
    emit(ReviewLoaded(
      awaitingReviews: state.awaitingReviews,
      writtenReviews: state.writtenReviews,
      selectedReview: state.selectedReview,
      errorMessage: null,
      hasLoadedAwaiting: state.hasLoadedAwaiting,
      hasLoadedWritten: state.hasLoadedWritten,
      isLoadingAwaiting: true,
      lastWrittenReviewId: state.lastWrittenReviewId,
    ));

    final dataState = await _getAwaitingReviewsUsecase();
    if (dataState is DataSuccess) {
      emit(ReviewLoaded(
        awaitingReviews: dataState.data ?? [],
        writtenReviews: state.writtenReviews,
        selectedReview: state.selectedReview,
        errorMessage: null,
        hasLoadedAwaiting: true,
        hasLoadedWritten: state.hasLoadedWritten,
        lastWrittenReviewId: state.lastWrittenReviewId,
      ));
      return;
    }

    emit(ReviewFailure(
      errorMessage: dataState.errorMessage,
      awaitingReviews: state.awaitingReviews,
      writtenReviews: state.writtenReviews,
      selectedReview: state.selectedReview,
      hasLoadedAwaiting: state.hasLoadedAwaiting,
      hasLoadedWritten: state.hasLoadedWritten,
    ));
  }

  Future<void> _onGetWrittenReviews(
    GetWrittenReviews event,
    Emitter<ReviewState> emit,
  ) async {
    emit(ReviewLoaded(
      awaitingReviews: state.awaitingReviews,
      writtenReviews: state.writtenReviews,
      selectedReview: state.selectedReview,
      errorMessage: null,
      hasLoadedAwaiting: state.hasLoadedAwaiting,
      hasLoadedWritten: state.hasLoadedWritten,
      isLoadingWritten: true,
      lastWrittenReviewId: state.lastWrittenReviewId,
    ));

    final dataState = await _getWrittenReviewsUsecase();
    if (dataState is DataSuccess) {
      emit(ReviewLoaded(
        awaitingReviews: state.awaitingReviews,
        writtenReviews: dataState.data ?? [],
        selectedReview: state.selectedReview,
        errorMessage: null,
        hasLoadedAwaiting: state.hasLoadedAwaiting,
        hasLoadedWritten: true,
        lastWrittenReviewId: state.lastWrittenReviewId,
      ));
      return;
    }

    emit(ReviewFailure(
      errorMessage: dataState.errorMessage,
      awaitingReviews: state.awaitingReviews,
      writtenReviews: state.writtenReviews,
      selectedReview: state.selectedReview,
      hasLoadedAwaiting: state.hasLoadedAwaiting,
      hasLoadedWritten: state.hasLoadedWritten,
    ));
  }

  Future<void> _onWriteReview(
    WriteReview event,
    Emitter<ReviewState> emit,
  ) async {
    emit(ReviewLoaded(
      awaitingReviews: state.awaitingReviews,
      writtenReviews: state.writtenReviews,
      selectedReview: state.selectedReview,
      hasLoadedAwaiting: state.hasLoadedAwaiting,
      hasLoadedWritten: state.hasLoadedWritten,
      isWritingReview: true,
      lastWrittenReviewId: state.lastWrittenReviewId,
      pendingWriteOrderId: event.params.orderId,
      pendingWriteServiceId: event.params.serviceId,
      writeReviewErrorMessage: null,
      writeReviewErrorOrderId: null,
      writeReviewErrorServiceId: null,
    ));

    final dataState = await _writeReviewUsecase(params: event.params);
    if (dataState is DataSuccess) {
      final review = dataState.data!;
      final updatedWritten = [
        review,
        ...state.writtenReviews.where((r) => r.id != review.id),
      ];
      final updatedAwaiting = state.awaitingReviews
          .where(
            (a) =>
                !(a.orderId == event.params.orderId &&
                    a.serviceId == event.params.serviceId),
          )
          .toList();

      emit(ReviewLoaded(
        awaitingReviews: updatedAwaiting,
        writtenReviews: updatedWritten,
        selectedReview: review,
        hasLoadedAwaiting: state.hasLoadedAwaiting,
        hasLoadedWritten: true,
        lastWrittenReviewId: review.id,
        pendingWriteOrderId: null,
        pendingWriteServiceId: null,
        writeReviewErrorMessage: null,
        writeReviewErrorOrderId: null,
        writeReviewErrorServiceId: null,
      ));
      return;
    }

    emit(ReviewLoaded(
      awaitingReviews: state.awaitingReviews,
      writtenReviews: state.writtenReviews,
      selectedReview: state.selectedReview,
      hasLoadedAwaiting: state.hasLoadedAwaiting,
      hasLoadedWritten: state.hasLoadedWritten,
      isWritingReview: false,
      pendingWriteOrderId: null,
      pendingWriteServiceId: null,
      writeReviewErrorMessage: dataState.errorMessage,
      writeReviewErrorOrderId: event.params.orderId,
      writeReviewErrorServiceId: event.params.serviceId,
    ));
  }

  Future<void> _onGetReviewById(
    GetReviewById event,
    Emitter<ReviewState> emit,
  ) async {
    emit(ReviewLoaded(
      awaitingReviews: state.awaitingReviews,
      writtenReviews: state.writtenReviews,
      selectedReview: state.selectedReview,
      hasLoadedAwaiting: state.hasLoadedAwaiting,
      hasLoadedWritten: state.hasLoadedWritten,
      isLoadingDetail: true,
      lastWrittenReviewId: state.lastWrittenReviewId,
    ));

    final dataState = await _getReviewByIdUsecase(params: event.reviewId);
    if (dataState is DataSuccess) {
      emit(ReviewLoaded(
        awaitingReviews: state.awaitingReviews,
        writtenReviews: state.writtenReviews,
        selectedReview: dataState.data,
        hasLoadedAwaiting: state.hasLoadedAwaiting,
        hasLoadedWritten: state.hasLoadedWritten,
        lastWrittenReviewId: state.lastWrittenReviewId,
      ));
      return;
    }

    emit(ReviewFailure(
      errorMessage: dataState.errorMessage,
      awaitingReviews: state.awaitingReviews,
      writtenReviews: state.writtenReviews,
      selectedReview: state.selectedReview,
      hasLoadedAwaiting: state.hasLoadedAwaiting,
      hasLoadedWritten: state.hasLoadedWritten,
      isLoadingDetail: false,
    ));
  }
}
