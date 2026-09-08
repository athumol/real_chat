import '../../repositories/friend_repository.dart';
import '../../../data/models/friend_model.dart';

class GetFriends {
  final FriendRepository repository;

  GetFriends({required this.repository});

  Stream<List<FriendModel>> call(String userId) {
    return repository.getFriends(userId);
  }
}
