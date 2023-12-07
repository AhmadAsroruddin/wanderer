import 'package:equatable/equatable.dart';

class BankAccount extends Equatable {
  const BankAccount(
      {required this.name,
      required this.account,
      required this.bank,
      required this.aliasName,
      required this.email});
  final String name;
  final String account;
  final String bank;
  final String aliasName;
  final String email;

  @override
  List<Object?> get props => [name, account, bank, aliasName, email];
}
