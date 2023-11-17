import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/owner.dart';
import 'package:wanderer/domain/repositories/owner_reposiroty.dart';

class AddOwner {
  OwnerRepository ownerRepository;

  AddOwner({required this.ownerRepository});

  Future<Either<String, String>> execute(Owner owner, String adminId) {
    return ownerRepository.addOwner(owner, adminId);
  }
}
