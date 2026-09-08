import '../../repositories/friend_repository.dart';
import '../../../data/models/friend_request_model.dart';

class GetOutgoingRequests {
  final FriendRepository repository;

  GetOutgoingRequests({required this.repository});

  Stream<List<FriendRequestModel>> call(String userId) {
    return repository.getOutgoingRequests(userId);
  }
}
