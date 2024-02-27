import 'package:wanderer/data/models/admin_model.dart';

import '../repositories/admin_repository.dart';

class AdminUpdate {
  final AdminRepos adminRepo;

  AdminUpdate({required this.adminRepo});

  Future<void> execute(AdminModel admin) async {
    await adminRepo.updateAdmin(admin);
  }
}
