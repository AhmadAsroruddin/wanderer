import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/entities/tipe.dart';

abstract class AdminRepos {
  Future<String> addToAdmin(Admin admin, String adminId);
  Future<Either<String, String>> addTypeToAdmin(Tipe tipe, String adminId);
  Future<Admin> getAdmin(String markerId);
  Future<List<Tipe>> getTypes(String adminId);
  Future<void> setUserRole(String userId);
}
