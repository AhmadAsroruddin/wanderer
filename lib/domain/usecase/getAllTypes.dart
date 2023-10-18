import 'package:wanderer/domain/repositories/admin_repository.dart';

import '../entities/tipe.dart';

class GetAllTypes {
  AdminRepos adminRepos;
  GetAllTypes({required this.adminRepos});

  Future<List<Tipe>> execute(String adminId) async {
    return adminRepos.getTypes(adminId);
  }
}
