import 'package:clean_app/src/domain/dtos/remote_hr_req_param.dart';
import 'package:either_dart/either.dart';

abstract class FormHRRepository {
  const FormHRRepository();

  Future<Either<Exception, void>> submitFormHR(FormHrReqParams params);
}
