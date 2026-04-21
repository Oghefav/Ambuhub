import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:equatable/equatable.dart';

abstract class GetServiceCatState extends Equatable {
  final List<ServiceCategoryEntity>? categories;
  final String? error;
  const GetServiceCatState({this.categories, this.error});

  @override
  List<Object?> get props => [categories, error];
}

class GetServiceCatInitial extends GetServiceCatState {
  const GetServiceCatInitial();
}

class GetServiceCatLoading extends GetServiceCatState {
  const GetServiceCatLoading();
}

class GetServiceCatSuccess extends GetServiceCatState {
  const GetServiceCatSuccess({required super.categories});
}

class GetServiceCatFailure extends GetServiceCatState {
  const GetServiceCatFailure({required super.error});
}
