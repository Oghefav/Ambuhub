import 'package:ambuhub/features/hire/domain/entities/hire_params.dart';
import 'package:equatable/equatable.dart';

abstract class HireEvent extends Equatable {
  const HireEvent();

  @override
  List<Object?> get props => [];
}

class PlaceHire extends HireEvent {
  final HireParams params;

  const PlaceHire({required this.params});

  @override
  List<Object?> get props => [params];
}

class HireReset extends HireEvent {
  const HireReset();
}
