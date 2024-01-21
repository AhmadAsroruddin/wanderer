import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:wanderer/data/datasource/admin_datasource.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/entities/tipe.dart';
import 'package:wanderer/domain/entities/user.dart';
import 'package:wanderer/domain/repositories/admin_repository.dart';

class AdminReposImpl implements AdminRepos {
  final AdminDataSource adminDataSource;

  AdminReposImpl({required this.adminDataSource});

  @override
  Future<String> addToAdmin(Admin admin, String markerId) async {
    String id = await adminDataSource.addToAdmin(admin, markerId);
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

  @override
  Future<Admin> getAdmin(String markerId) async {
    final result = await adminDataSource.getAdmin(markerId);

    return result;
  }

  @override
  Future<List<Tipe>> getTypes(String adminId) async {
    final result = await adminDataSource.getTypes(adminId);
    return result;
  }

  @override
  Future<void> setUserRole(String userId, String adminId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection('users')
        .doc(userId)
        .update({'role': adminId});
  }

  @override
  Future<Either<String, List<Admin>>> getCampervanRental(
      bool onSearch, String key) async {
    try {
      final result = await adminDataSource.getCampervanRental(onSearch, key);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Users> adminUser(String adminId) async {
    try {
      final result = await adminDataSource.getAdminUser(adminId);
      return result;
    } catch (e) {
      print("USER ADMIN ERROR : $e");
      Map<String, dynamic> temp = {'asd': 'asd'};
      return temp as Users;
    }
  }
}
