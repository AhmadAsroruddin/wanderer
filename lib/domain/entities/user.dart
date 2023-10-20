import 'package:equatable/equatable.dart';

class Users extends Equatable {
  const Users(
      {required this.username,
      required this.email,
      required this.imageUrl,
      required this.telponNumber,
      required this.markers,
      required this.role});

  final String username;
  final String email;
  final String imageUrl;
  final String telponNumber;
  final List<dynamic> markers;
  final String role;

  @override
  List<Object> get props =>
      [username, email, imageUrl, telponNumber, role, markers];
}
