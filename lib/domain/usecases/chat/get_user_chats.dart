import '../../repositories/chat_repository.dart';
import '../../../data/models/chat_model.dart';

class GetUserChats {
  final ChatRepository repository;

  GetUserChats({required this.repository});

  Stream<List<ChatModel>> call(String userId) {
    return repository.getUserChats(userId: userId);
  }
}
