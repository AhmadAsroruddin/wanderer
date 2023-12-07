import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:wanderer/domain/entities/bankAccount.dart';

abstract class PayoutDatasource {
  Future<void> createBeneficaries(BankAccount bankAccount);
  Future<String> createPayout(
      BankAccount bankAccount, String amount, String notes);
  Future<void> approve(String id);
}

class PayoutDatasourceImpl implements PayoutDatasource {
  final Dio dio;

  PayoutDatasourceImpl({required this.dio});

  @override
  Future<void> createBeneficaries(BankAccount bankAccount) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Basic SVJJUy00ZDkyMTYyZC1hYjA4LTRkNjQtOTY0ZS0zMGI5OWM1Njc1NGQ6'
    };
    var data = json.encode({
      "name": bankAccount.name,
      "account": bankAccount.account,
      "bank": bankAccount.bank,
      "alias_name": bankAccount.aliasName,
      "email": bankAccount.email
    });
    var dio = Dio();
    var response = await dio.request(
      'https://app.midtrans.com/iris/api/v1/beneficiaries?=',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  @override
  Future<String> createPayout(
      BankAccount bankAccount, String amount, String notes) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Basic SVJJUy00ZDkyMTYyZC1hYjA4LTRkNjQtOTY0ZS0zMGI5OWM1Njc1NGQ6'
    };
    var data = json.encode({
      "payouts": [
        {
          "beneficiary_name": bankAccount.name,
          "beneficiary_account": bankAccount.account,
          "beneficiary_bank": bankAccount.bank,
          "beneficiary_email": bankAccount.email,
          "amount": amount,
          "notes": notes
        }
      ]
    });
    var dio = Dio();
    var response = await dio.request(
      'https://app.midtrans.com/iris/api/v1/payouts',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    Map<String, dynamic> responseData = response.data;

    List<dynamic> payouts = responseData['payouts'];

    if (response.statusCode == 201) {
      print(json.encode(response.data));
      Map<String, dynamic> payoutData = payouts[0];
      String referenceNo = payoutData['reference_no'];
      return referenceNo;
    } else {
      print(response.statusMessage);
      return response.statusMessage.toString();
    }
  }

  @override
  Future<void> approve(String id) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Basic SVJJUy1jM2JiNDk4Yy0wODNhLTQ2MTAtYTgwZC1hYjZlYTA3YjQ0NTA6'
    };
    var data = json.encode({
      "reference_nos": [id],
      "otp": "335163"
    });
    var dio = Dio();
    var response = await dio.request(
      'https://app.midtrans.com/iris/api/v1/payouts/approve',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }
}
