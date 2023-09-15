import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class CreateAccount {
  final AuthRepos authRepos;

  CreateAccount({required this.authRepos});

  Future<Either<String, dynamic>> execute(
      String username, String email, String password, String telponNumber) {
    return authRepos.createAccount(username, email, password, telponNumber);
  }
}
