import 'package:dartz/dartz.dart';
import 'package:wanderer/data/models/user_model.dart';
import 'package:wanderer/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<String, Users>> getUserData();
  Future<void> updateUser(UserModel userData);
}
