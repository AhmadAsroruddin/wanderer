import 'package:wanderer/domain/repositories/user_repository.dart';

class DeleteUserUsecase {
  final UserRepository userRepository;

  DeleteUserUsecase({required this.userRepository});

  Future<void> execute() async {
    userRepository.deleteUser();
  }
}
