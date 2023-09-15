import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
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

  @override
  List<Object> get props => [username, email, imageUrl, telponNumber, markers];
}
