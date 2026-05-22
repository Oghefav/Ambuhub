import 'package:ambuhub/features/services/domain/enitities/service.dart';

enum ServiceDetailReturnTarget {
  reviews,
  favourites,
  marketplace,
  category,
}

class MarketPlaceServiceDetailArgs {
  final String serviceId;
  final ServiceDetailReturnTarget returnTarget;
  final String? returnLabel;

  const MarketPlaceServiceDetailArgs({
    required this.serviceId,
    this.returnTarget = ServiceDetailReturnTarget.marketplace,
    this.returnLabel,
  });

  String resolveBackLabel({ServiceEntity? service}) {
    if (returnLabel != null && returnLabel!.isNotEmpty) {
      return returnLabel!;
    }
    return switch (returnTarget) {
      ServiceDetailReturnTarget.reviews => 'Back to reviews',
      ServiceDetailReturnTarget.favourites => 'Back to favourites',
      ServiceDetailReturnTarget.marketplace => 'Back to marketplace',
      ServiceDetailReturnTarget.category =>
        service != null && service.serviceCategory.isNotEmpty
            ? 'Back to ${service.serviceCategory}'
            : 'Back to category',
    };
  }

  factory MarketPlaceServiceDetailArgs.fromService(
    ServiceEntity service, {
    ServiceDetailReturnTarget returnTarget = ServiceDetailReturnTarget.category,
    String? returnLabel,
  }) {
    return MarketPlaceServiceDetailArgs(
      serviceId: service.id,
      returnTarget: returnTarget,
      returnLabel: returnLabel,
    );
  }
}
