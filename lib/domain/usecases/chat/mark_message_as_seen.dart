import '../../repositories/chat_repository.dart';

class MarkMessageAsSeen {
  final ChatRepository repository;

  MarkMessageAsSeen({required this.repository});

  Future<void> call({required String chatId, required String messageId}) {
    return repository.markMessageAsSeen(chatId: chatId, messageId: messageId);
  }
}
