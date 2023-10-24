import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:wanderer/data/models/transaction_status_model.dart';
import 'package:wanderer/domain/entities/order.dart';
import 'package:wanderer/domain/entities/paymentUrl.dart';
import 'package:wanderer/domain/entities/transactionStatus.dart';

abstract class PaymentDataSource {
  Future<PaymentUrl> getUrl(double price, OrderData order);
  Future<TransactionStatus> getStatus(String orderId);
}

class PaymentDataSourceImpl implements PaymentDataSource {
  final Dio dio;

  PaymentDataSourceImpl({
    required this.dio,
  });

  @override
  Future<PaymentUrl> getUrl(double price, OrderData order) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Basic U0ItTWlkLXNlcnZlci1IMGY3SU40VGVpbllQMUk2cXZGd011Tmg6'
    };
    final String time = DateTime.now().toString();
    var data = json.encode({
      "transaction_details": {
        "order_id": "ORDER-101-$time",
        "gross_amount": price
      },
      "credit_card": {"secure": true}
    });

    var response = await dio.request(
      'https://app.sandbox.midtrans.com/snap/v1/transactions',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    Map<String, dynamic> jsonData = json.decode(data);
    String orderId = jsonData["transaction_details"]["order_id"];

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('admin')
        .doc(order.orderedPlaceId)
        .collection('order list')
        .doc(order.id)
        .update({"orderId": orderId});
    await firestore
        .collection('order list')
        .doc(order.id)
        .update({'orderId': orderId});
    if (response.statusCode == 201) {
      final data = response.data;
      final token = data['token'];
      final redirectUrl = data['redirect_url'];
      print(data);
      return PaymentUrl(token: token, redirectUrl: redirectUrl);
    } else {
      throw Exception("Failed to get link URL");
    }
  }

  @override
  Future<TransactionStatus> getStatus(String orderId) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Basic U0ItTWlkLXNlcnZlci1IMGY3SU40VGVpbllQMUk2cXZGd011Tmg6'
    };

    var response = await dio.request(
      'https://api.sandbox.midtrans.com/v2/$orderId/status',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      TransactionStatusModel transactionData =
          TransactionStatusModel.fromJson(data);

      return transactionData.toEntity();
    } else {
      throw Exception("Failed to get link URL");
    }
  }
}
