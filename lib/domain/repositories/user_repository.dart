import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<String, Users>> getUserData();
}
