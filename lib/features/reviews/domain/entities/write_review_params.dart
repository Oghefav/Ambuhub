import 'package:equatable/equatable.dart';

class WriteReviewParams extends Equatable {
  final String orderId;
  final String serviceId;
  final int rating;
  final String body;

  const WriteReviewParams({
    required this.orderId,
    required this.serviceId,
    required this.rating,
    required this.body,
  });

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'serviceId': serviceId,
        'rating': rating,
        'body': body,
      };

  @override
  List<Object?> get props => [orderId, serviceId, rating, body];
}
