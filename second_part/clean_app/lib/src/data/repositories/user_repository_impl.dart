import 'package:clean_app/src/data/models/get_user_id_response.dart';
import 'package:clean_app/src/data/providers/user_provider_offline.dart';
import 'package:clean_app/src/data/providers/user_provider_remote.dart';
import 'package:clean_app/src/domain/repositories/user_repository_abs.dart';

class UserRepositoryImpl extends UserRepository {
  const UserRepositoryImpl(this._userProviderRemote, this._userProviderOffline);

  final UserProviderRemote _userProviderRemote;
  final UserProviderOffline _userProviderOffline;

  @override
  Future<GetUserIDResponse> getUserID() async {
    try {
      final id = await _userProviderRemote.getUserID();
      return GetUserIDSuccessResponse(id);
    } on Exception catch (e, st) {
      return GetUserIDFailedResponse(e);
    }
  }
}
