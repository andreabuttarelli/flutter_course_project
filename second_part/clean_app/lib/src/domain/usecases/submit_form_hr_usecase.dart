import 'package:clean_app/src/domain/dtos/remote_hr_req_param.dart';
import 'package:clean_app/src/domain/repositories/form_hr_repository_abs.dart';
import 'package:clean_app/src/domain/usecases/usecase.dart';
import 'package:either_dart/either.dart';

class SubmitFormHRUseCase
    extends UseCase<Either<Exception, void>, SubmitFormHRUseCaseParams> {
  const SubmitFormHRUseCase(this._formHRRepository);

  final FormHRRepository _formHRRepository;

  @override
  Future<Either<Exception, void>> call(SubmitFormHRUseCaseParams params) async {
    final reqParam = FormHrReqParams(
      country: params.country,
      street: params.street,
      name: params.name,
      experience: params.experience,
    );
    final res = await _formHRRepository.submitFormHR(reqParam);
    return res;
  }
}

class SubmitFormHRUseCaseParams extends UseCaseParams {
  const SubmitFormHRUseCaseParams({
    required this.country,
    required this.street,
    required this.name,
    required this.experience,
  });

  final String country;
  final String street;
  final String name;
  final double experience;
}
