import 'package:wanderer/data/models/tipe_model.dart';
import 'package:wanderer/domain/repositories/admin_repository.dart';

class UpdateTipe {
  AdminRepos adminRepos;
  UpdateTipe({required this.adminRepos});

  Future<void> execute(TipeModel tipe) async {
    await adminRepos.updateType(tipe);
  }
}
