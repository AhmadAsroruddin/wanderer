import 'package:wanderer/domain/entities/bankAccount.dart';
import 'package:wanderer/domain/repositories/payout_repository.dart';

class CreatePayout {
  final PayoutRepos payoutRepos;

  CreatePayout({required this.payoutRepos});

  Future<String> execute(BankAccount bankAccount, String amount, String notes) {
    return payoutRepos.createPayout(bankAccount, amount, notes);
  }
}
