import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/provider_notifications/domain/entities/provider_notification_entity.dart';
import 'package:ambuhub/features/provider_notifications/domain/repository/provider_notifications_repo.dart';

class MarkProviderNotificationReadUsecase
    implements Usecase<DataState<ProviderNotificationEntity?>, String> {
  final ProviderNotificationsRepo _repo;

  const MarkProviderNotificationReadUsecase(this._repo);

  @override
  Future<DataState<ProviderNotificationEntity?>> call({String? params}) {
    return _repo.markAsRead(params!);
  }
}
