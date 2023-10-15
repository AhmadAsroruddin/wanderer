import 'package:dartz/dartz.dart';
import 'package:wanderer/data/datasource/admin_datasource.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/entities/tipe.dart';
import 'package:wanderer/domain/repositories/admin_repository.dart';

class AdminReposImpl implements AdminRepos {
  final AdminDataSource adminDataSource;

  AdminReposImpl({required this.adminDataSource});

  @override
  Future<String> addToAdmin(Admin admin) async {
    String id = await adminDataSource.addToAdmin(admin);
    return id;
  }

  @override
  Future<Either<String, String>> addTypeToAdmin(
      Tipe tipe, String adminId) async {
    try {
      await adminDataSource.addTypeToAdmin(tipe, adminId);
      return const Right("You're now an Admin");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
