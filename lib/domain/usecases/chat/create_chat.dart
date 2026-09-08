import '../../repositories/chat_repository.dart';
import '../../../data/models/chat_model.dart';

class CreateChat {
  final ChatRepository repository;

  CreateChat({required this.repository});

  Future<ChatModel> call({required List<String> members}) {
    return repository.createChat(members: members);
  }
}
