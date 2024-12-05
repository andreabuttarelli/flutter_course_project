import 'package:clean_app/src/domain/dtos/remote_hr_req_param.dart';

class FormHRProvider {
  const FormHRProvider();

  Future<void> submitFormHR(FormHrReqParams params) async {
    await Future.delayed(const Duration(seconds: 1));
    throw Exception('Qualcosa è andato storto');
  }
}
