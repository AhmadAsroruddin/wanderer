import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:wanderer/domain/entities/user.dart';

class UserModel extends Equatable {
  const UserModel(
      {required this.username,
      required this.email,
      required this.imageUrl,
      required this.telponNumber,
      required this.markers,
      required this.role,
      required this.token});

  final String username;
  final String email;
  final String imageUrl;
  final String telponNumber;
  final List<dynamic> markers;
  final String role;
  final String token;

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'imageUrl': imageUrl,
      'telponNumber': telponNumber,
      'markers': markers,
      'role': role,
      'token': token
    };
  }

  static Users fromMap(Map<String, dynamic> map) {
    return Users(
        username: map['username'],
        email: map['email'],
        imageUrl: map['imageUrl'],
        telponNumber: map['telponNumber'],
        markers: map['markers'],
        role: map['role'],
        token: map['token']);
  }

  factory UserModel.fromDocumentSnapShot(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;

    return UserModel(
        username: map['username'],
        email: map['email'],
        imageUrl: map['imageUrl'],
        telponNumber: map['telponNumber'],
        markers: map['markers'],
        role: map['role'],
        token: map['token']);
  }

  factory UserModel.fromEntity(Users users) {
    return UserModel(
        username: users.username,
        email: users.email,
        imageUrl: users.imageUrl,
        telponNumber: users.telponNumber,
        markers: users.markers,
        role: users.role,
        token: users.token);
  }
  Users toEntity() {
    return Users(
        username: username,
        email: email,
        imageUrl: imageUrl,
        telponNumber: telponNumber,
        markers: markers,
        role: role,
        token: token);
  }

  @override
  List<Object> get props =>
      [username, email, imageUrl, telponNumber, role, markers, token];
}
