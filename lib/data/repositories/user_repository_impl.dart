
import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore;
import 'package:real_chat/core/constants/firestore_constants.dart';
import 'package:real_chat/data/models/user_model.dart';
import 'package:real_chat/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;

  UserRepositoryImpl({required this.firestore});

  @override
  Future<void> createUser(UserModel user) async {
    await firestore
        .collection(FirestoreConstants.users)
        .doc(user.uid)
        .set(user.toMap());
  }

  @override
  Future<UserModel?> getUser(String uid) async {
    final doc = await firestore
        .collection(FirestoreConstants.users)
        .doc(uid)
        .get();

    if (!doc.exists) {
      return null;
    }

    return UserModel.fromMap(doc.data()!);
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await firestore
        .collection(FirestoreConstants.users)
        .get();

    return snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data()))
        .toList();
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await firestore
        .collection(FirestoreConstants.users)
        .doc(user.uid)
        .update(user.toMap());
  }

  @override
  Future<void> updateOnlineStatus(String uid, bool isOnline) async {
    await firestore
        .collection(FirestoreConstants.users)
        .doc(uid)
        .update({
      'isOnline': isOnline,
      'lastSeen': DateTime.now(),
    });
  }
}
