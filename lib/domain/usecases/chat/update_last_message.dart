import '../../repositories/chat_repository.dart';

class UpdateLastMessage {
  final ChatRepository repository;

  UpdateLastMessage({required this.repository});

  Future<void> call({
    required String chatId,
    required String lastMessage,
    required String lastMessageType,
  }) {
    return repository.updateLastMessage(
      chatId: chatId,
      lastMessage: lastMessage,
      lastMessageType: lastMessageType,
    );
  }
}
