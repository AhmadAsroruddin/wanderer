import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/bankAccount.dart';
import 'package:wanderer/domain/repositories/payout_repository.dart';

class CreateBeneficaries {
  CreateBeneficaries({required this.payoutRepos});

  PayoutRepos payoutRepos;

  Future<Either<String, String>> execute(BankAccount bankAccount) async {
    return payoutRepos.createBeneficaries(bankAccount);
  }
}
