import 'package:dartz/dartz.dart';
import 'package:wanderer/data/datasource/user_datasource.dart';
import 'package:wanderer/domain/entities/user.dart';
import 'package:wanderer/domain/repositories/user_repository.dart';

class UserReposImpl extends UserRepository {
  UserDataSource userDataSource;

  UserReposImpl({required this.userDataSource});

  @override
  Future<Either<String, Users>> getUserData() async {
    try {
      final data = await userDataSource.getUserData();
      return Right(data);
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }
}
