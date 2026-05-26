import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/provider_notifications/domain/repository/provider_notifications_repo.dart';

class GetProviderUnreadNotificationCountUsecase
    implements Usecase<DataState<int>, void> {
  final ProviderNotificationsRepo _repo;

  const GetProviderUnreadNotificationCountUsecase(this._repo);

  @override
  Future<DataState<int>> call({void params}) => _repo.getUnreadCount();
}
