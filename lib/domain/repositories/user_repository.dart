import 'package:dartz/dartz.dart';
import 'package:wanderer/data/models/report_model.dart';
import 'package:wanderer/data/models/user_model.dart';
import 'package:wanderer/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<String, Users>> getUserData(String uid);
  Future<void> updateUser(UserModel userData);
  Future<void> report(ReportModel reportModel);
  Future<void> addToken();
  Future<void> deleteUser();
}
