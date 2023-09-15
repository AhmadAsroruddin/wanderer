import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/repositories/auth_repository.dart';

class ResetPassword {
  final AuthRepos authRepos;

  ResetPassword({required this.authRepos});

  Future<Either<String, String>> execute(String email) async {
    await authRepos.resetPassword(email);
    return authRepos.logout();
  }
}
