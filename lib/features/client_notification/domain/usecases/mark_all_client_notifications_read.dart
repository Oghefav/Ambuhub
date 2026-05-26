import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/client_notification/domain/repository/client_notifications_repo.dart';

class MarkAllClientNotificationsReadUsecase
    implements Usecase<DataState<void>, void> {
  final ClientNotificationsRepo _repo;

  const MarkAllClientNotificationsReadUsecase(this._repo);

  @override
  Future<DataState<void>> call({void params}) => _repo.markAllAsRead();
}
