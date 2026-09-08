import '../../repositories/chat_repository.dart';
import '../../../data/models/message_model.dart';

class SendMessage {
  final ChatRepository repository;

  SendMessage({required this.repository});

  Future<void> call({required String chatId, required MessageModel message}) {
    return repository.sendMessage(chatId: chatId, message: message);
  }
}
