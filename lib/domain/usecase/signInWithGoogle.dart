import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/repositories/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepos authRepos;

  SignInWithGoogle({required this.authRepos});

  Future<Either<String, String>> execute() async {
    return authRepos.signInWithGoogle();
  }
}
