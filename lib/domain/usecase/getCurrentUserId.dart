import 'package:wanderer/domain/repositories/auth_repository.dart';

class GetCurrentUserId {
  AuthRepos authRepos;
  GetCurrentUserId({required this.authRepos});

  Future<String> execute() {
    return authRepos.getUserId();
  }
}
