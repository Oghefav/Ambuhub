import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/hire/domain/entities/hire_entity.dart';
import 'package:ambuhub/features/hire/domain/entities/hire_params.dart';

abstract class HireRepo {
  Future<DataState<HireEntity>> placeHire(HireParams params);
}
