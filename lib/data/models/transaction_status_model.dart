import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:wanderer/domain/entities/transactionStatus.dart';

class TransactionStatusModel extends Equatable {
  final DateTime transactionTime;
  final String grossAmount;
  final String currency;
  final String orderId;
  final String paymentType;
  final String signatureKey;
  final String statusCode;
  final String transactionId;
  final String transactionStatus;
  final String fraudStatus;
  final DateTime expiryTime;
  final DateTime settlementTime;
  final String statusMessage;
  final String merchantId;

  const TransactionStatusModel({
    required this.transactionTime,
    required this.grossAmount,
    required this.currency,
    required this.orderId,
    required this.paymentType,
    required this.signatureKey,
    required this.statusCode,
    required this.transactionId,
    required this.transactionStatus,
    required this.fraudStatus,
    required this.expiryTime,
    required this.settlementTime,
    required this.statusMessage,
    required this.merchantId,
  });

  factory TransactionStatusModel.fromRawJson(String str) =>
      TransactionStatusModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionStatusModel.fromJson(Map<String, dynamic> json) =>
      TransactionStatusModel(
        transactionTime: DateTime.parse(json["transaction_time"]),
        grossAmount: json["gross_amount"],
        currency: json["currency"],
        orderId: json["order_id"],
        paymentType: json["payment_type"],
        signatureKey: json["signature_key"],
        statusCode: json["status_code"],
        transactionId: json["transaction_id"],
        transactionStatus: json["transaction_status"],
        fraudStatus: json["fraud_status"],
        expiryTime: DateTime.parse(json["expiry_time"]),
        settlementTime: DateTime.parse(json["settlement_time"]),
        statusMessage: json["status_message"],
        merchantId: json["merchant_id"],
      );
  TransactionStatus toEntity() {
    return TransactionStatus(
        transactionTime: transactionTime,
        grossAmount: grossAmount,
        currency: currency,
        orderId: orderId,
        paymentType: paymentType,
        signatureKey: signatureKey,
        statusCode: statusCode,
        transactionId: transactionId,
        transactionStatus: transactionStatus,
        fraudStatus: fraudStatus,
        expiryTime: expiryTime,
        settlementTime: settlementTime,
        statusMessage: statusMessage,
        merchantId: merchantId);
  }

  Map<String, dynamic> toJson() => {
        "transaction_time": transactionTime.toIso8601String(),
        "gross_amount": grossAmount,
        "currency": currency,
        "order_id": orderId,
        "payment_type": paymentType,
        "signature_key": signatureKey,
        "status_code": statusCode,
        "transaction_id": transactionId,
        "transaction_status": transactionStatus,
        "fraud_status": fraudStatus,
        "expiry_time": expiryTime.toIso8601String(),
        "settlement_time": settlementTime.toIso8601String(),
        "status_message": statusMessage,
        "merchant_id": merchantId,
      };

  @override
  List<Object> get props => [
        transactionId,
        transactionTime,
        grossAmount,
        currency,
        orderId,
        paymentType,
        statusCode,
        transactionId,
        transactionStatus,
        fraudStatus,
        expiryTime,
        settlementTime,
        statusMessage,
        merchantId,
      ];
}
