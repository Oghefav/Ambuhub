import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/client_notification/domain/entities/client_notification_entity.dart';
import 'package:ambuhub/features/client_notification/domain/repository/client_notifications_repo.dart';

class GetClientNotificationsUsecase
    implements Usecase<DataState<List<ClientNotificationEntity>>, void> {
  final ClientNotificationsRepo _repo;

  const GetClientNotificationsUsecase(this._repo);

  @override
  Future<DataState<List<ClientNotificationEntity>>> call({void params}) {
    return _repo.getNotifications();
  }
}
