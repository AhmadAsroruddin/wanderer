import 'package:dartz/dartz.dart';

abstract class AuthRepos {
  Future<Either<String, dynamic>> createAccount(
      String username, String email, String password, String telponNumber);
  Future<Either<String, dynamic>> login(String email, String password);
  Future<Either<String, String>> logout();
  Future<Either<String, String>> signInWithGoogle();
  Future<Either<String, String>> resetPassword(String email);
  Future<bool> isFirstTime();
  Future<void> gettingStartedDone();
}
