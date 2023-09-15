import 'package:wanderer/domain/repositories/auth_repository.dart';

class IsFirstTime {
  final AuthRepos authRepos;

  IsFirstTime({required this.authRepos});

  Future<bool> execute() async {
    return authRepos.isFirstTime();
  }
}
