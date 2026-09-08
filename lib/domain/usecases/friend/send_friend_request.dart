import 'package:real_chat/domain/repositories/friend_repository.dart';

class SendFriendRequest {
  final FriendRepository repository;

  SendFriendRequest({required this.repository});

  Future<void> call({required String senderId, required String receiverId}) {
    return repository.sendFriendRequest(
      senderId: senderId,
      receiverId: receiverId,
    );
  }
}
