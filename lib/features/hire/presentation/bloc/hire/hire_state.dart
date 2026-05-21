import 'package:ambuhub/features/hire/domain/entities/hire_entity.dart';
import 'package:equatable/equatable.dart';

abstract class HireState extends Equatable {
  final HireEntity? order;
  final String? errorMessage;

  const HireState({this.order, this.errorMessage});

  @override
  List<Object?> get props => [order, errorMessage];
}

class HireInitial extends HireState {
  const HireInitial();
}

class HireLoading extends HireState {
  const HireLoading();
}

class HireSuccess extends HireState {
  const HireSuccess({required super.order});
}

class HireFailure extends HireState {
  const HireFailure({required super.errorMessage});
}
