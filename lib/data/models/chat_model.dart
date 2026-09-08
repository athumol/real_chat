class ChatModel {
  final String chatId;
  final List<String> members;
  final String lastMessage;
  final DateTime lastMessageTime;
  final DateTime createdAt;
  final String lastMessageType;

  ChatModel({
    required this.chatId,
    required this.members,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.createdAt,
    required this.lastMessageType,
  });

  ChatModel copyWith({
    String? chatId,
    List<String>? members,
    String? lastMessage,
    DateTime? lastMessageTime,
    DateTime? createdAt,
    String? lastMessageType,
  }) {
    return ChatModel(
      chatId: chatId ?? this.chatId,
      members: members ?? this.members,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      createdAt: createdAt ?? this.createdAt,
      lastMessageType: lastMessageType ?? this.lastMessageType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'members': members,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'createdAt': createdAt,
      'lastMessageType': lastMessageType,
    };
  }

  factory ChatModel.fromMap({
    required String chatId,
    required Map<String, dynamic> map,
  }) {
    return ChatModel(
      chatId: chatId,
      members: List<String>.from(map['members'] ?? []),
      lastMessage: map['lastMessage'] ?? '',
      lastMessageTime: map['lastMessageTime'].toDate(),
      createdAt: map['createdAt'].toDate(),
      lastMessageType: map['lastMessageType'] ?? 'text',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'members': members,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'createdAt': createdAt,
      'lastMessageType': lastMessageType,
    };
  }

  factory ChatModel.fromJson({
    required String chatId,
    required Map<String, dynamic> json,
  }) {
    return ChatModel(
      chatId: chatId,
      members: List<String>.from(json['members'] ?? []),
      lastMessage: json['lastMessage'] ?? '',
      lastMessageTime: json['lastMessageTime'].toDate(),
      createdAt: json['createdAt'].toDate(),
      lastMessageType: json['lastMessageType'] ?? 'text',
    );
  }
 @override
String toString() {
  return 'ChatModel('
      'chatId: $chatId, '
      'members: $members, '
      'lastMessage: $lastMessage, '
      'lastMessageTime: $lastMessageTime, '
      'createdAt: $createdAt, '
      'lastMessageType: $lastMessageType'
      ')';
}
}
