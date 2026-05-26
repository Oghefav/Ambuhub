import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/client_notification/domain/repository/client_notifications_repo.dart';

class GetClientUnreadNotificationCountUsecase
    implements Usecase<DataState<int>, void> {
  final ClientNotificationsRepo _repo;

  const GetClientUnreadNotificationCountUsecase(this._repo);

  @override
  Future<DataState<int>> call({void params}) => _repo.getUnreadCount();
}
