import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/repositories/admin_repository.dart';

class AddToAdmin {
  final AdminRepos adminRepos;
  AddToAdmin({required this.adminRepos});

  Future<Either<String, String>> execute(Admin admin) async {
    return adminRepos.addToAdmin(admin);
  }
}
