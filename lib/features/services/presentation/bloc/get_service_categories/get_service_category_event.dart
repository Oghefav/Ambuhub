import 'package:equatable/equatable.dart';

abstract class GetServiceCategoriesEvent extends Equatable {
  const GetServiceCategoriesEvent();

  @override
  List<Object?> get props => [];
}

class GetServiceCategories extends GetServiceCategoriesEvent {
  const GetServiceCategories();
}
