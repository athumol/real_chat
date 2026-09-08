class FriendModel {
  final String friendUid;
  final DateTime friendSince;
  final bool isBlocked;
  final bool isPinned;
  final String id;

  FriendModel({
    required this.id,
    required this.friendUid,
    required this.friendSince,
    required this.isBlocked,
    required this.isPinned,
  });

  FriendModel copyWith({
    String? id,
    String? friendUid,
    DateTime? friendSince,
    bool? isBlocked,
    bool? isPinned,
  }) {
    return FriendModel(
      id: id ?? this.id,
      friendUid: friendUid ?? this.friendUid,
      friendSince: friendSince ?? this.friendSince,
      isBlocked: isBlocked ?? this.isBlocked,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'friendUid': friendUid,
      'friendSince': friendSince,
      'isBlocked': isBlocked,
      'isPinned': isPinned,
    };
  }

  factory FriendModel.fromMap(Map<String, dynamic> map,String id) {
    return FriendModel(
      id: id,
      friendUid: map['friendUid'] ?? '',
      friendSince: map['friendSince'].toDate(),
      isBlocked: map['isBlocked'] ?? false,
      isPinned: map['isPinned'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'friendUid': friendUid,
      'friendSince': friendSince.toIso8601String(),
      'isBlocked': isBlocked,
      'isPinned': isPinned,
    };
  }

  factory FriendModel.fromJson(Map<String, dynamic> json,) {
    return FriendModel(
      id: json['id'] ?? '',
      friendUid: json['friendUid'] ?? '',
      friendSince: DateTime.parse(json['friendSince']),
      isBlocked: json['isBlocked'] ?? false,
      isPinned: json['isPinned'] ?? false,
    );
  }
@override
  String toString() {
    return 'FriendModel(friendUid: $friendUid, friendsince: $friendSince, isBlocked:$isBlocked, isPinned:$isPinned)';
  }
}
