import '../../repositories/user_repository.dart';
import '../../../data/models/user_model.dart';

class CreateUser {
  final UserRepository repository;

  CreateUser({required this.repository});

  Future<void> call(UserModel user) {
    return repository.createUser(user);
  }
}
