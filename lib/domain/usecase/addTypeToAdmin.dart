import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/tipe.dart';

import '../repositories/admin_repository.dart';

class AddTypeToAdmin {
  final AdminRepos adminRepos;
  AddTypeToAdmin({required this.adminRepos});

  Future<Either<String, String>> execute(Tipe tipe, String adminId) {
    return adminRepos.addTypeToAdmin(tipe, adminId);
  }
}
