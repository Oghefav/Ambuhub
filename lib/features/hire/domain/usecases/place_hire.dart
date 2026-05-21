import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/hire/domain/entities/hire_entity.dart';
import 'package:ambuhub/features/hire/domain/entities/hire_params.dart';
import 'package:ambuhub/features/hire/domain/repository/hire_repo.dart';

class PlaceHireUsecase implements Usecase<DataState<HireEntity>, HireParams> {
  final HireRepo _hireRepo;

  const PlaceHireUsecase(this._hireRepo);

  @override
  Future<DataState<HireEntity>> call({HireParams? params}) {
    return _hireRepo.placeHire(params!);
  }
}
