import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:real_chat/core/constants/firestore_constants.dart';
import 'package:real_chat/data/models/chat_model.dart';
import 'package:real_chat/data/models/message_model.dart';
import 'package:real_chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseFirestore firestore;

  ChatRepositoryImpl({required this.firestore});
  @override
  Future<ChatModel> createChat({required List<String> members}) async {
    if (members.length < 2) {
      throw ArgumentError('A chat must have at least two members.');
    }
    final sortedMembers = [...members]..sort();
    final chatId = sortedMembers.join('_');
    final chatRef = firestore.collection(FirestoreConstants.chats).doc(chatId);
    final existingChat = await chatRef.get();

    if (existingChat.exists) {
      return ChatModel.fromMap(chatId: chatId, map: existingChat.data()!);
    }

    final now = FieldValue.serverTimestamp();

    await chatRef.set({
      'members': sortedMembers,
      'lastMessage': '',
      'lastMessageTime': now,
      'createdAt': now,
      'lastMessageType': 'text',
    });

    final createdChat = await chatRef.get();

    return ChatModel.fromMap(chatId: chatId, map: createdChat.data()!);
  }

  @override
  Stream<List<ChatModel>> getUserChats({required String userId}) {
    return firestore
        .collection(FirestoreConstants.chats)
        .where('memebers', arrayContains: userId)
        .snapshots()
        .map((snapshots) {
          return snapshots.docs
              .map((doc) => ChatModel.fromMap(chatId: doc.id, map: doc.data()))
              .toList();
        });
  }

  @override
  Future<ChatModel?> getChat({required String chatId}) async {
    final doc = await firestore
        .collection(FirestoreConstants.chats)
        .doc(chatId)
        .get();

    if (!doc.exists || doc.data() == null) {
      return null;
    }
    return ChatModel.fromMap(chatId: doc.id, map: doc.data()!);
  }

  @override
  Future<void> sendMessage({
    required String chatId,
    required MessageModel message,
  }) async {
    final batch = firestore.batch();

    final chatRef = firestore.collection(FirestoreConstants.chats).doc(chatId);

    final messageRef = chatRef.collection(FirestoreConstants.messages).doc();

    batch.set(messageRef, {
      ...message.toMap(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    batch.update(chatRef, {
      'lastMessage': message.text,
      'lastMessageType': message.type,
      'lastMessageTime': FieldValue.serverTimestamp(),
    });

    await batch.commit();
  }

  @override
  Stream<List<MessageModel>> getMessages({required String chatId}) {
    return firestore
        .collection(FirestoreConstants.chats)
        .doc(chatId)
        .collection(FirestoreConstants.messages)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => MessageModel.fromMap(doc.data()))
              .toList();
        });
  }

  @override
  Future<void> markMessageAsSeen({
    required String chatId,
    required String messageId,
  }) async {
    await firestore
        .collection(FirestoreConstants.chats)
        .doc(chatId)
        .collection(FirestoreConstants.messages)
        .doc(messageId)
        .update({'isSeen': true});
  }

  @override
  Future<void> updateLastMessage({
    required String chatId,
    required String lastMessage,
    required String lastMessageType,
  }) async {
    await firestore.collection(FirestoreConstants.chats).doc(chatId).update({
      'lastMessage': lastMessage,
      'lastMessageType': lastMessageType,
      'lastMessageTime': FieldValue.serverTimestamp(),
    });
  }
}
