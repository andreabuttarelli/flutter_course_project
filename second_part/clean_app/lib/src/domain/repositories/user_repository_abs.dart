import 'package:clean_app/src/data/models/get_user_id_response.dart';

abstract class UserRepository {
  const UserRepository();

  Future<GetUserIDResponse> getUserID();
}
