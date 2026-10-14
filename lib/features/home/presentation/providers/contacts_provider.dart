import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_chat/data/models/friend_model.dart';
import 'package:real_chat/data/models/friend_request_model.dart';
import 'package:real_chat/data/models/user_model.dart';

import 'package:real_chat/core/providers/repository_providers.dart';


final allUsersProvider = FutureProvider<List<UserModel>>((ref) async {
  final userRepository = ref.read(userRepositoryProvider);
  return userRepository.getAllUsers();
});

final outgoingRequestsProvider =
    StreamProvider.family<List<FriendRequestModel>, String>((ref, userId) {
      return ref.read(friendRepositoryProvider).getOutgoingRequests(userId);
    });

final friendsProvider = StreamProvider.family<List<FriendModel>, String>((
  ref,
  userId,
) {
  return ref.read(friendRepositoryProvider).getFriends(userId);
});
// final outgoingRequestsProvider =
//     StreamProvider.family<List<FriendRequestModel>, String>(
//   (ref, userId) {
//     return ref
//         .read(friendRepositoryProvider)
//         .getOutgoingRequests(userId);
//   },
// );

// final friendsProvider =
//     StreamProvider.family<List<FriendModel>, String>(
//   (ref, userId) {
//     return ref.read(friendRepositoryProvider).getFriends(userId);
//   },
// );
