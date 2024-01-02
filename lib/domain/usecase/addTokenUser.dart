import 'package:wanderer/domain/repositories/user_repository.dart';

class AddTokenUser {
  UserRepository userRepository;

  AddTokenUser({required this.userRepository});

  Future<void> addToken() async {
    await userRepository.addToken();
  }
}
