import 'package:wanderer/domain/repositories/admin_repository.dart';

import '../entities/user.dart';

class GetUserAdmin {
  AdminRepos adminRepos;
  GetUserAdmin({required this.adminRepos});

  Future<Users> execute(String adminId) async {
    Users result = await adminRepos.adminUser(adminId);
    return result;
  }
}
