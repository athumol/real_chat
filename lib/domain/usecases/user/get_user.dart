import '../../repositories/user_repository.dart';
import '../../../data/models/user_model.dart';

class GetUser {
  final UserRepository repository;

  GetUser({required this.repository});

  Future<UserModel?> call(String uid) {
    return repository.getUser(uid);
  }
}
