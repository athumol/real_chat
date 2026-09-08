import 'package:real_chat/data/models/chat_model.dart';
import 'package:real_chat/data/models/message_model.dart';

abstract class ChatRepository {
  // Create a new chat between users
  Future<ChatModel> createChat({required List<String> members});
  // Get all chats for a user in realtime
  Stream<List<ChatModel>> getUserChats({required String userId});

  // Get a specific chat
  Future<ChatModel?> getChat({required String chatId});

  // Send a message
  Future<void> sendMessage({
    required String chatId,
    required MessageModel message,
  });

  // Get messages in realtime
  Stream<List<MessageModel>> getMessages({required String chatId});

  // Mark a message as seen

  Future<void> markMessageAsSeen({
    required String chatId,
    required String messageId,
  });

  // Update the chat preview

  Future<void> updateLastMessage({
    required String chatId,
    required String lastMessage,
    required String lastMessageType,
  });
}
