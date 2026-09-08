class UserModel {
  final String uid;
  final String name;
  final String username;
  final String phoneNumber;
  final String email;
  final String? profileImage;
  final String? about;
  final bool isOnline;
  final DateTime createdAt;
  final DateTime lastSeen;

  const UserModel({
    required this.uid,
    required this.name,
    required this.username,
    required this.phoneNumber,
    required this.email,
    this.profileImage,
    this.about,
    required this.isOnline,
    required this.createdAt,
    required this.lastSeen,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? username,
    String? phoneNumber,
    String? email,
    String? profileImage,
    String? about,
    bool? isOnline,
    DateTime? createdAt,
    DateTime? lastSeen,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      isOnline: isOnline ?? this.isOnline,
      createdAt: createdAt ?? this.createdAt,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "username": username,
      "phoneNumber": phoneNumber,
      "email": email,
      "profileImage": profileImage,
      "about": about,
      "isOnline": isOnline,
      "createdAt": createdAt,
      "lastSeen": lastSeen,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      profileImage: map['profileImage'] ?? '',
      about: map['about'] ?? '',
      isOnline: map['isOnline'] ?? false,
      createdAt: map['createdAt'].toDate(),
      lastSeen: map['lastSeen'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'username': username,
      'phoneNumber': phoneNumber,
      'email': email,
      'ProfileImage': profileImage,
      'about': about,
      'isOnline': isOnline,
      'createdAt': createdAt.toIso8601String(),
      'lastSeen': lastSeen.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'] ?? '',
      about: json['about'] ?? '',
      isOnline: json['isOnline'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      lastSeen: DateTime.parse(json['lastSeen']),
    );
  }
@override
  String toString(){
    return 'UserModel (uid: $uid, name: $name, username: $username)';
  }
}
