import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/repositories/auth_repository.dart';

class Login {
  final AuthRepos authRepos;

  Login({required this.authRepos});

  Future<Either<String, dynamic>> execute(String email, String password) {
    return authRepos.login(email, password);
  }
}
