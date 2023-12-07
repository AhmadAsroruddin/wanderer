import 'dart:convert';

import 'package:equatable/equatable.dart';

class BankAccountModel extends Equatable {
  const BankAccountModel(
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

  factory BankAccountModel.fromRawJson(String str) =>
      BankAccountModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankAccountModel.fromJson(Map<String, dynamic> json) =>
      BankAccountModel(
          name: json["name"],
          account: json["account"],
          bank: json["bank"],
          aliasName: json["alias_name"],
          email: json["email"]);

  Map<String, dynamic> toJson() => {
        name: name,
        account: account,
        bank: bank,
        aliasName: aliasName,
        email: email
      };

  @override
  List<Object?> get props => [name, account, bank, aliasName, email];
}
