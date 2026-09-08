import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_chat/domain/usecases/chat/create_chat.dart';
import 'package:real_chat/domain/usecases/chat/get_chat.dart';
import 'package:real_chat/domain/usecases/chat/get_messages.dart';
import 'package:real_chat/domain/usecases/chat/get_user_chats.dart';
import 'package:real_chat/domain/usecases/chat/mark_message_as_seen.dart';
import 'package:real_chat/domain/usecases/chat/send_message.dart';
import 'package:real_chat/domain/usecases/chat/update_last_message.dart';
import 'package:real_chat/domain/usecases/friend/accept_friend_request.dart';
import 'package:real_chat/domain/usecases/friend/get_friends.dart';
import 'package:real_chat/domain/usecases/friend/get_incoming_requests.dart';
import 'package:real_chat/domain/usecases/friend/get_outgoing_requests.dart';
import 'package:real_chat/domain/usecases/friend/reject_friend_request.dart';
import 'package:real_chat/domain/usecases/friend/remove_friend.dart';
import 'package:real_chat/domain/usecases/friend/send_friend_request.dart';
import 'package:real_chat/domain/usecases/user/get_user.dart';
import 'package:real_chat/domain/usecases/user/update_user.dart';

import '../../domain/usecases/user/create_user.dart';
import 'repository_providers.dart';

final createUserProvider = Provider<CreateUser>((ref) {
  final repository = ref.read(userRepositoryProvider);

  return CreateUser(
    repository: repository,
  );
});

final getUserProvider = Provider<GetUser>((ref) {
  final repository = ref.read(userRepositoryProvider);

  return GetUser(
    repository: repository,
  );
});

final updateUserProvider = Provider<UpdateUser>((ref) {
  final repository = ref.read(userRepositoryProvider);

  return UpdateUser(
    repository: repository,
  );
});

//friend

final sendFriendRequestProvider = Provider<SendFriendRequest>((ref) {
  final repository = ref.read(friendRepositoryProvider);

  return SendFriendRequest(
    repository: repository,
  );
});
final getIncomingRequestsProvider =
    Provider<GetIncomingRequests>((ref) {
  final repository = ref.read(friendRepositoryProvider);

  return GetIncomingRequests(
    repository: repository,
  );
});
final getOutgoingRequestsProvider =
    Provider<GetOutgoingRequests>((ref) {
  final repository = ref.read(friendRepositoryProvider);

  return GetOutgoingRequests(
    repository: repository,
  );
});
final acceptFriendRequestProvider =
    Provider<AcceptFriendRequest>((ref) {
  final repository = ref.read(friendRepositoryProvider);

  return AcceptFriendRequest(
    repository: repository,
  );
});
final rejectFriendRequestProvider =
    Provider<RejectFriendRequest>((ref) {
  final repository = ref.read(friendRepositoryProvider);

  return RejectFriendRequest(
    repository: repository,
  );
});
final getFriendsProvider = Provider<GetFriends>((ref) {
  final repository = ref.read(friendRepositoryProvider);

  return GetFriends(
    repository: repository,
  );
});
final removeFriendProvider = Provider<RemoveFriend>((ref) {
  final repository = ref.read(friendRepositoryProvider);

  return RemoveFriend(
    repository: repository,
  );
});

//chat

final createChatProvider = Provider<CreateChat>((ref) {
  final repository = ref.read(chatRepositoryProvider);

  return CreateChat(
    repository: repository,
  );
});
final getUserChatsProvider = Provider<GetUserChats>((ref) {
  final repository = ref.read(chatRepositoryProvider);

  return GetUserChats(
    repository: repository,
  );
});
final getChatProvider = Provider<GetChat>((ref) {
  final repository = ref.read(chatRepositoryProvider);

  return GetChat(
    repository: repository,
  );
});
final sendMessageProvider = Provider<SendMessage>((ref) {
  final repository = ref.read(chatRepositoryProvider);

  return SendMessage(
    repository: repository,
  );
});
final getMessagesProvider = Provider<GetMessages>((ref) {
  final repository = ref.read(chatRepositoryProvider);

  return GetMessages(
    repository: repository,
  );
});
final markMessageAsSeenProvider =
    Provider<MarkMessageAsSeen>((ref) {
  final repository = ref.read(chatRepositoryProvider);

  return MarkMessageAsSeen(
    repository: repository,
  );
});
final updateLastMessageProvider =
    Provider<UpdateLastMessage>((ref) {
  final repository = ref.read(chatRepositoryProvider);

  return UpdateLastMessage(
    repository: repository,
  );
});