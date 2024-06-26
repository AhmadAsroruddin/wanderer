import 'package:dartz/dartz.dart';
import 'package:wanderer/data/models/admin_model.dart';
import 'package:wanderer/data/models/tipe_model.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/entities/tipe.dart';

import '../entities/user.dart';

abstract class AdminRepos {
  Future<String> addToAdmin(Admin admin, String adminId);
  Future<Either<String, String>> addTypeToAdmin(Tipe tipe, String adminId);
  Future<Admin> getAdmin(String markerId);
  Future<List<Tipe>> getTypes(String adminId);
  Future<void> setUserRole(String userId, String adminId);
  Future<Either<String, List<Admin>>> getCampervanRental(
      bool onSearch, String key);
  Future<Users> adminUser(String adminId);
  Future<void> updateAdmin(AdminModel admin);
  Future<void> updateType(TipeModel tipe);
}
