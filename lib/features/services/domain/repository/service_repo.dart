import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/enitities/service_params.dart';

abstract class ServiceRepo {
  Future<DataState<ServiceEntity>> addService(ServiceParams service);
  Future<DataState<List<ServiceEntity>>> getProviderServices();
  Future<DataState<List<ServiceCategoryEntity>>> getServiceCategories();
  Future<DataState<List<ServiceEntity>>> getMarketplaceServices(
    String categorySlug,
  );
  Future<DataState<ServiceEntity>> getMarketplaceServiceById(String serviceId);
  Future<DataState<ServiceEntity>> updateService(ServiceParams service);
}
