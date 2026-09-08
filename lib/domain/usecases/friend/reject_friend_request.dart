import '../../repositories/friend_repository.dart';

class RejectFriendRequest {
  final FriendRepository repository;

  RejectFriendRequest({
    required this.repository,
  });

  Future<void> call({
    required String requestId,
  }) {
    return repository.rejectFriendRequest(
      requestId: requestId,
    );
  }
}