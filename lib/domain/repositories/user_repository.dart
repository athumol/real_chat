import 'package:real_chat/data/models/user_model.dart';

abstract class UserRepository {
  Future<void> createUser(UserModel user);
  Future<UserModel?> getUser(String uid);
  Future<void> updateUser(UserModel user);
  Future<void> updateOnlineStatus(String uid, bool isOnline);
}
