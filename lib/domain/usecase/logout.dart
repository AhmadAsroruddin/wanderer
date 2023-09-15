import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/repositories/auth_repository.dart';

class Logout {
  final AuthRepos authRepos;

  Logout({required this.authRepos});

  Future<Either<String, String>> execute() {
    return authRepos.logout();
  }
}
