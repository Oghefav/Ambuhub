import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/provider_notifications/domain/repository/provider_notifications_repo.dart';

class MarkAllProviderNotificationsReadUsecase
    implements Usecase<DataState<void>, void> {
  final ProviderNotificationsRepo _repo;

  const MarkAllProviderNotificationsReadUsecase(this._repo);

  @override
  Future<DataState<void>> call({void params}) => _repo.markAllAsRead();
}
