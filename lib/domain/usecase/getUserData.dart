import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/user.dart';
import 'package:wanderer/domain/repositories/user_repository.dart';

class GetUserData {
  UserRepository userRepository;

  GetUserData({required this.userRepository});

  Future<Either<String, Users>> execute() {
    return userRepository.getUserData();
  }
}
