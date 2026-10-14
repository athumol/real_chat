import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_chat/data/repositories/chat_repository_impl.dart';
import 'package:real_chat/data/repositories/friend_repository_impl.dart';
import 'package:real_chat/domain/repositories/chat_repository.dart';
import 'package:real_chat/domain/repositories/friend_repository.dart';

import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/user_repository.dart';
import 'firebase_providers.dart';


final userRepositoryProvider = Provider<UserRepository>((ref) {
  final firestore = ref.read(firestoreProvider);

  return UserRepositoryImpl(firestore: firestore);
});
final friendRepositoryProvider = Provider<FriendRepository>((ref) {
  final firestore = ref.read(firestoreProvider);

  return FriendRepositoryImpl(firestore: firestore);
});
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final firestore = ref.read(firestoreProvider);

  return ChatRepositoryImpl(firestore: firestore);
});
