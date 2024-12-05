import 'package:clean_app/src/data/providers/form_hr_provider_offline.dart';
import 'package:clean_app/src/domain/dtos/remote_hr_req_param.dart';
import 'package:clean_app/src/domain/repositories/form_hr_repository_abs.dart';
import 'package:either_dart/either.dart';

class FormHRRepositoryImpl extends FormHRRepository {
  const FormHRRepositoryImpl(this._provider);

  final FormHRProvider _provider;

  @override
  Future<Either<Exception, void>> submitFormHR(FormHrReqParams params) async {
    try {
      await _provider.submitFormHR(params);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
