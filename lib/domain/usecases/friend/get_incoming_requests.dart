import '../../repositories/friend_repository.dart';
import '../../../data/models/friend_request_model.dart';

class GetIncomingRequests {
  final FriendRepository repository;

  GetIncomingRequests({required this.repository});

  Stream<List<FriendRequestModel>> call(String userId) {
    return repository.getIncomingRequests(userId);
  }
}
