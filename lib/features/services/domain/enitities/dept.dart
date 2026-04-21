import 'package:equatable/equatable.dart';

class ServiceDeptEntity extends Equatable {
  final String name;
  final String slug;

  const ServiceDeptEntity({required this.name, required this.slug});

  @override
  List<Object> get props => [name, slug];
  }
