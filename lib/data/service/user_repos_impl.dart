import 'package:dartz/dartz.dart';
import 'package:wanderer/data/datasource/user_datasource.dart';
import 'package:wanderer/data/models/report_model.dart';
import 'package:wanderer/data/models/user_model.dart';
import 'package:wanderer/domain/entities/user.dart';
import 'package:wanderer/domain/repositories/user_repository.dart';

class UserReposImpl extends UserRepository {
  UserDataSource userDataSource;

  UserReposImpl({required this.userDataSource});

  @override
  Future<Either<String, Users>> getUserData(String uid) async {
    try {
      final data = await userDataSource.getUserData(uid);
      return Right(data);
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  @override
  Future<void> updateUser(UserModel userData) async {
    try {
      await userDataSource.updateUserProfile(userData);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> report(ReportModel reportModel) async {
    try {
      await userDataSource.reportSend(reportModel);
    } catch (e) {
      print(e);
    }
  }
}
