import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/entities/tipe.dart';

abstract class AdminRepos {
  Future<String> addToAdmin(Admin admin);
  Future<Either<String, String>> addTypeToAdmin(Tipe tipe, String adminId);
}
