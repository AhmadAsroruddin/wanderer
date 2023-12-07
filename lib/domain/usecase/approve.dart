import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/repositories/payout_repository.dart';

class Approve {
  final PayoutRepos payoutRepos;

  Approve({required this.payoutRepos});

  Future<Either<String, String>> execute(String id) async {
    return payoutRepos.approve(id);
  }
}
