import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_chat/core/constants/app_constants.dart';
import 'package:real_chat/core/constants/firestore_constants.dart';
import 'package:real_chat/data/models/friend_model.dart';
import 'package:real_chat/data/models/friend_request_model.dart';
import 'package:real_chat/domain/repositories/friend_repository.dart';

class FriendRepositoryImpl implements FriendRepository {
  final FirebaseFirestore firestore;

  FriendRepositoryImpl({required this.firestore});
  @override
  

@override
Future<void> sendFriendRequest({
  required String senderId,
  required String receiverId,
}) async {
  if (senderId == receiverId) {
    throw Exception('You cannot add yourself as a friend.');
  }

  final requests =
      firestore.collection(FirestoreConstants.friendRequests);

  // Check whether a pending request already exists.
  final outgoing = await requests
      .where('senderId', isEqualTo: senderId)
      .where('receiverId', isEqualTo: receiverId)
      .where('status', isEqualTo: AppConstants.pending)
      .limit(1)
      .get();

  if (outgoing.docs.isNotEmpty) {
    throw Exception('Friend request already sent.');
  }

  // Check whether the other person has already requested you.
  final incoming = await requests
      .where('senderId', isEqualTo: receiverId)
      .where('receiverId', isEqualTo: senderId)
      .where('status', isEqualTo: AppConstants.pending)
      .limit(1)
      .get();

  if (incoming.docs.isNotEmpty) {
    throw Exception(
      'This person has already sent you a request.',
    );
  }

  // Check whether you are already friends.
  final friendship = await firestore
      .collection(FirestoreConstants.users)
      .doc(senderId)
      .collection(FirestoreConstants.friends)
      .doc(receiverId)
      .get();

  if (friendship.exists) {
    throw Exception('You are already friends.');
  }

  await requests.add({
    'senderId': senderId,
    'receiverId': receiverId,
    'status': AppConstants.pending,
    'createdAt': FieldValue.serverTimestamp(),
  });
}
// Future<void> sendFriendRequest({
//   required String senderId,
//   required String receiverId,
// }) async {
//   if (senderId == receiverId) {
//     throw ArgumentError('You cannot send a friend request to yourself.');
//   }

//   final requests = firestore.collection(FirestoreConstants.friendRequests);

//   final existingOutgoing = await requests
//       .where('senderId', isEqualTo: senderId)
//       .where('receiverId', isEqualTo: receiverId)
//       .where('status', isEqualTo: AppConstants.pending)
//       .limit(1)
//       .get();

//   if (existingOutgoing.docs.isNotEmpty) {
//     throw StateError('A friend request is already pending.');
//   }

//   final existingIncoming = await requests
//       .where('senderId', isEqualTo: receiverId)
//       .where('receiverId', isEqualTo: senderId)
//       .where('status', isEqualTo: AppConstants.pending)
//       .limit(1)
//       .get();

//   if (existingIncoming.docs.isNotEmpty) {
//     throw StateError('This user has already sent you a friend request.');
//   }

//   final existingFriend = await firestore
//       .collection(FirestoreConstants.users)
//       .doc(senderId)
//       .collection(FirestoreConstants.friends)
//       .doc(receiverId)
//       .get();

//   if (existingFriend.exists) {
//     throw StateError('You are already friends.');
//   }

//   await requests.add({
//     'senderId': senderId,
//     'receiverId': receiverId,
//     'status': AppConstants.pending,
//     'createdAt': FieldValue.serverTimestamp(),
//   });
// }


  @override
  Future<void> acceptFriendRequest({
    required FriendRequestModel request,
  }) async {
    final batch = firestore.batch();
    //update request status
    final requestRef = firestore
        .collection(FirestoreConstants.friendRequests)
        .doc(request.id);

    batch.update(requestRef, {'status': AppConstants.accepted});
    //create friendship for sender
    final senderFriendRef = firestore
        .collection(FirestoreConstants.users)
        .doc(request.senderId)
        .collection(FirestoreConstants.friends)
        .doc(request.receiverId);

    batch.set(senderFriendRef, {
      'friendId': request.receiverId,
      'createdAt': FieldValue.serverTimestamp(),
    });

    //create friendship for receiver
    final receiverFriendRef = firestore
        .collection(FirestoreConstants.users)
        .doc(request.receiverId)
        .collection(FirestoreConstants.friends)
        .doc(request.senderId);

    batch.set(receiverFriendRef, {
      'friendId': request.senderId,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await batch.commit();
  }

  @override
  Future<void> rejectFriendRequest({required String requestId}) async {
    await firestore
        .collection(FirestoreConstants.friendRequests)
        .doc(requestId)
        .update({'status': AppConstants.rejected});
  }

 @override
Stream<List<FriendRequestModel>> getIncomingRequests(
  String userId,
) {
  print('Incoming requests query UID: $userId');

  return firestore
      .collection(FirestoreConstants.friendRequests)
      .where('receiverId', isEqualTo: userId)
      .where('status', isEqualTo: AppConstants.pending)
      .snapshots()
      .map((snapshot) {
        print(
          'Incoming requests found: ${snapshot.docs.length}',
        );

        return snapshot.docs
            .map(
              (doc) => FriendRequestModel.fromMap(
                doc.data(),
                doc.id,
              ),
            )
            .toList();
      });
}

  @override
  Stream<List<FriendRequestModel>> getOutgoingRequests(String userId) {
    return firestore
        .collection(FirestoreConstants.friendRequests)
        .where('senderId', isEqualTo: userId)
        .where('status', isEqualTo: AppConstants.pending)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => FriendRequestModel.fromMap(doc.data(), doc.id))
              .toList();
        });
  }

  @override
  Stream<List<FriendModel>> getFriends(String userId) {
    return firestore
        .collection(FirestoreConstants.users)
        .doc(userId)
        .collection(FirestoreConstants.friends)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => FriendModel.fromMap(doc.data(), doc.id))
              .toList();
        });
  }

  @override
  Future<void> removeFriend({
    required String userId,
    required String friendId,
  }) async {
    final batch = firestore.batch();

    final userFriendRef = firestore
        .collection(FirestoreConstants.users)
        .doc(userId)
        .collection(FirestoreConstants.friends)
        .doc(friendId);

    final friendFriendRef = firestore
        .collection(FirestoreConstants.friends)
        .doc(friendId)
        .collection(FirestoreConstants.users)
        .doc(userId);

    batch.delete(userFriendRef);
    batch.delete(friendFriendRef);

    await batch.commit();
  }
}
