import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/enitities/service_params.dart';

abstract class ServiceRepo {
  Future<DataState<ServiceEntity>> addService(ServiceParams service);
  Future<DataState<List<ServiceEntity>>> getServices();
}
