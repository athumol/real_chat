import '../../repositories/chat_repository.dart';
import '../../../data/models/chat_model.dart';

class GetChat {
  final ChatRepository repository;

  GetChat({required this.repository});

  Future<ChatModel?> call(String chatId) {
    return repository.getChat(chatId: chatId);
  }
}
