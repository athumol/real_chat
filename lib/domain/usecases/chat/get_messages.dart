import '../../repositories/chat_repository.dart';
import '../../../data/models/message_model.dart';

class GetMessages {
  final ChatRepository repository;

  GetMessages({required this.repository});

  Stream<List<MessageModel>> call(String chatId) {
    return repository.getMessages(chatId: chatId);
  }
}
