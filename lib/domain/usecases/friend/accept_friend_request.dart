import '../../repositories/friend_repository.dart';
import '../../../data/models/friend_request_model.dart';

class AcceptFriendRequest {
  final FriendRepository repository;

  AcceptFriendRequest({required this.repository});

  Future<void> call({required FriendRequestModel request}) {
    return repository.acceptFriendRequest(request: request);
  }
}
