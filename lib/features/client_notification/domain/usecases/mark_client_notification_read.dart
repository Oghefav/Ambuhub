import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/client_notification/domain/entities/client_notification_entity.dart';
import 'package:ambuhub/features/client_notification/domain/repository/client_notifications_repo.dart';

class MarkClientNotificationReadUsecase
    implements Usecase<DataState<ClientNotificationEntity?>, String> {
  final ClientNotificationsRepo _repo;

  const MarkClientNotificationReadUsecase(this._repo);

  @override
  Future<DataState<ClientNotificationEntity?>> call({String? params}) {
    return _repo.markAsRead(params!);
  }
}
