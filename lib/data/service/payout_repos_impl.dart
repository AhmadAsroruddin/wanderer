import 'package:dartz/dartz.dart';
import 'package:wanderer/data/datasource/payout_datasource.dart';
import 'package:wanderer/domain/entities/bankAccount.dart';
import 'package:wanderer/domain/repositories/payout_repository.dart';

class PayoutReposImpl implements PayoutRepos {
  PayoutDatasource payoutDatasource;

  PayoutReposImpl({required this.payoutDatasource});

  @override
  Future<Either<String, String>> createBeneficaries(
      BankAccount bankAccount) async {
    try {
      await payoutDatasource.createBeneficaries(bankAccount);
      return const Right("Berhasil dibuat");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<String> createPayout(
      BankAccount bankAccount, String amount, String notes) async {
    try {
      String response =
          await payoutDatasource.createPayout(bankAccount, amount, notes);
      return response;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<Either<String, String>> approve(String id) async {
    try {
      await payoutDatasource.approve(id);
      return const Right("Dana berhasil terikirim");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
