import 'package:dartz/dartz.dart';
import 'package:wanderer/data/datasource/owner_datasource.dart';
import 'package:wanderer/domain/entities/owner.dart';
import 'package:wanderer/domain/repositories/owner_reposiroty.dart';

class OwnerReposImpl implements OwnerRepository {
  final OwnerDataSource ownerDataSource;

  OwnerReposImpl({required this.ownerDataSource});

  @override
  Future<Either<String, String>> addOwner(Owner owner, String adminId) async {
    try {
      await ownerDataSource.addOwner(owner, adminId);
      return Right("Owner berhasil dimasukan");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
