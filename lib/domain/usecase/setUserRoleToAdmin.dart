import 'package:wanderer/domain/repositories/admin_repository.dart';

class SetUserRoleToAdmin {
  AdminRepos adminRepos;
  SetUserRoleToAdmin({required this.adminRepos});

  Future<void> execute(String userId) async {
    await adminRepos.setUserRole(userId);
  }
}
