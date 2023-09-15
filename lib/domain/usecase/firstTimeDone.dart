import 'package:wanderer/domain/repositories/auth_repository.dart';

class FirstTimeDone {
  final AuthRepos authRepos;

  FirstTimeDone({required this.authRepos});

  Future<bool> execute() async {
    authRepos.gettingStartedDone();
    return true;
  }
}
