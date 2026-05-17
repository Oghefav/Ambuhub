import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:equatable/equatable.dart';

abstract class GetServiceCategoriesState extends Equatable {
  final List<ServiceCategoryEntity>? serviceCategories;
  final String? error;

  const GetServiceCategoriesState({this.serviceCategories, this.error});

  @override
  List<Object?> get props => [serviceCategories, error];
}

class GetServiceCategoriesInitial extends GetServiceCategoriesState {
  const GetServiceCategoriesInitial();
}

class GetServiceCategoriesLoading extends GetServiceCategoriesState {
  const GetServiceCategoriesLoading();
}

class GetServiceCategoriesSuccess extends GetServiceCategoriesState {
  const GetServiceCategoriesSuccess({required super.serviceCategories});
}

class GetServiceCategoriesError extends GetServiceCategoriesState {
  const GetServiceCategoriesError({required super.error});
}