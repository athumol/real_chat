import '../../repositories/user_repository.dart';
import '../../../data/models/user_model.dart';

class UpdateUser {
  final UserRepository repository;

  UpdateUser({required this.repository});

  Future<void> call(UserModel user) {
    return repository.updateUser(user);
  }
}
