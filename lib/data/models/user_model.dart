import 'package:equatable/equatable.dart';
import 'package:wanderer/domain/entities/user.dart';

class UserModel extends Equatable {
  const UserModel(
      {required this.username,
      required this.email,
      required this.imageUrl,
      required this.telponNumber,
      required this.markers});

  final String username;
  final String email;
  final String imageUrl;
  final String telponNumber;
  final List<String> markers;

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'imageUrl': imageUrl,
      'telponNumber': telponNumber,
      'markers': markers
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
        username: map['username'],
        email: map['email'],
        imageUrl: map['imageurl'],
        telponNumber: map['telponNumber'],
        markers: map['markers']);
  }

  User toEntity() {
    return User(
        username: username,
        email: email,
        imageUrl: imageUrl,
        telponNumber: telponNumber,
        markers: markers);
  }

  @override
  List<Object> get props => [username, email, imageUrl, telponNumber, markers];
}
