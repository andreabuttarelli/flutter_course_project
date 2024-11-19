import 'package:clean_app/src/data/models/get_user_id_response.dart';
import 'package:clean_app/src/domain/repositories/user_repository_abs.dart';
import 'package:clean_app/src/domain/usecases/usecase.dart';

import '../dtos/get_user_id_dto.dart';
import '../entities/user_entity.dart';

class GetUserIDUseCase extends UseCase<GetUserIDDto, UseCaseParams> {
  const GetUserIDUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<GetUserIDDto<Exception, UserEntity>> call(UseCaseParams params) async {
    final res = await _userRepository.getUserID();
    if (res is GetUserIDSuccessResponse) {
      final id = res.userID;
      return GetUserIDDto.right(UserEntity(id: id));
    } else {
      final e = (res as GetUserIDFailedResponse).exception;
      return GetUserIDDto.left(e);
    }
  }
}
