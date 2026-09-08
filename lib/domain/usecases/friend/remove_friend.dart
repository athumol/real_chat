import '../../repositories/friend_repository.dart';

class RemoveFriend {
  final FriendRepository repository;

  RemoveFriend({required this.repository});

  Future<void> call({required String userId, required String friendId}) {
    return repository.removeFriend(userId: userId, friendId: friendId);
  }
}
                                                                    