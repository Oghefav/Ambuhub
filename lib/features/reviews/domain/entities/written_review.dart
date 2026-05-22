import 'package:equatable/equatable.dart';

/// Review the client has already submitted.
class WrittenReviewEntity extends Equatable {
  final String id;
  final String serviceId;
  final String orderId;
  final int rating;
  final String body;
  final String serviceTitle;
  final String categorySlug;
  final String lineKind;
  final String reviewerDisplayName;
  final DateTime? createdAt;

  const WrittenReviewEntity({
    required this.id,
    required this.serviceId,
    required this.orderId,
    required this.rating,
    required this.body,
    required this.serviceTitle,
    required this.categorySlug,
    required this.lineKind,
    required this.reviewerDisplayName,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        serviceId,
        orderId,
        rating,
        body,
        serviceTitle,
        categorySlug,
        lineKind,
        reviewerDisplayName,
        createdAt,
      ];
}
