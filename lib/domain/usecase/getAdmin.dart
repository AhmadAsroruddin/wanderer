import 'package:wanderer/domain/repositories/admin_repository.dart';

import '../entities/admin.dart';

class GetAdmin {
  final AdminRepos adminRepos;

  GetAdmin({required this.adminRepos});

  Future<Admin> execute(String markerId) async {
    return adminRepos.getAdmin(markerId);
  }
}
