import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/bankAccount.dart';

abstract class PayoutRepos {
  Future<Either<String, String>> createBeneficaries(BankAccount bankAccount);
  Future<String> createPayout(
      BankAccount bankAccount, String amount, String notes);
  Future<Either<String, String>> approve(String id);
}
