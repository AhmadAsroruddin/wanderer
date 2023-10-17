import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/repositories/admin_repository.dart';

class AddToAdmin {
  final AdminRepos adminRepos;
  AddToAdmin({required this.adminRepos});

  Future<String> execute(Admin admin, String markerId) async {
    return adminRepos.addToAdmin(admin, markerId);
  }
}
