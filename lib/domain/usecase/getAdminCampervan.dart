import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/repositories/admin_repository.dart';

import '../entities/admin.dart';

class GetAdminCampervan {
  final AdminRepos adminRepos;

  GetAdminCampervan({required this.adminRepos});

  Future<Either<String, List<Admin>>> execute(bool onSearch, String key) {
    return adminRepos.getCampervanRental(onSearch, key);
  }
}
