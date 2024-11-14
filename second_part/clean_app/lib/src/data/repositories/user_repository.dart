import 'package:clean_app/src/data/models/get_user_id_response.dart';
import 'package:clean_app/src/data/providers/user_provider.dart';

class UserRepository {
  const UserRepository(this._userProvider);

  final UserProvider _userProvider;

  Future<GetUserIDResponse> getUserID() async {
    try {
      final id = await _userProvider.getUserID();
      return GetUserIDSuccessResponse(id);
    } on Exception catch (e, st) {
      return GetUserIDFailedResponse(e);
    }
  }
}

