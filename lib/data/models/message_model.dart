class MessageModel {
  final String senderId;
  final String text;
  final String type;
  final bool isSeen;
  final DateTime timestamp;
  final String? mediaUrl;

  const MessageModel({
    required this.senderId,
    required this.text,
    required this.type,
    required this.timestamp,
    required this.isSeen,
    this.mediaUrl,
  });
  MessageModel copyWith({
    String? senderId,
    String? text,
    String? type,
    DateTime? timestamp,
    bool? isSeen,
    String? mediaUrl,
  }) {
    return MessageModel(
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isSeen: isSeen ?? this.isSeen,
      mediaUrl: mediaUrl ?? this.mediaUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'type': type,
      'timestamp': timestamp,
      'isSeen': isSeen,
      'mediaUrl': mediaUrl,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] ?? '',
      text: map['text'] ?? '',
      type: map['type'] ?? 'text',
      timestamp: map['timestamp'].toDate(),
      isSeen: map['isSeen'] ?? false,
      mediaUrl: map['mediaUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'text': text,
      'type': type,
      'isSeen': isSeen,
      'timestamp': timestamp.toIso8601String(),
      'mediaUrl': mediaUrl,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'] ?? '',
      text: json['text'] ?? '',
      type: json['type'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      isSeen: json['isSeen'] ?? false,
      mediaUrl: json['mediaUrl'],
    );
  }
@override
  String toString() {
    return 'MessageModel(senderId: $senderId, text: $text, type: $type, timestamp: $timestamp, isSeen: $isSeen)';
  }
}
