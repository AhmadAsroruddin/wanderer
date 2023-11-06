import 'package:wanderer/data/models/user_model.dart';
import 'package:wanderer/domain/repositories/user_repository.dart';

class UpdateUser {
  final UserRepository userRepository;

  UpdateUser({required this.userRepository});

  Future<void> execute(UserModel userData) async {
    userRepository.updateUser(userData);
  }
}
