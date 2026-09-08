import 'package:real_chat/data/models/friend_model.dart';
import 'package:real_chat/data/models/friend_request_model.dart';

abstract class FriendRepository {
  // Send a friend request
  Future<void> sendFriendRequest({
    required String senderId,
    required String receiverId,
  });
  // Accept incoming request
  Future<void> acceptFriendRequest({required FriendRequestModel request});
  // reject icoming request
  Future<void> rejectFriendRequest({required String requestId});

  // Get incoming requests
  Stream<List<FriendRequestModel>> getIncomingRequests(String userId);

  // Get outgoing requests
  Stream<List<FriendRequestModel>> getOutgoingRequests(String userId);

  // get Friends List
  Stream<List<FriendModel>> getFriends(String userId);
  //remove friend
  Future<void> removeFriend({required String userId, required String friendId});
}
