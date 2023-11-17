import 'package:dartz/dartz.dart';

import '../entities/owner.dart';

abstract class OwnerRepository {
  Future<Either<String, String>> addOwner(Owner owner, String adminId);
}
