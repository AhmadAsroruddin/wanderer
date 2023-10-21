import 'package:equatable/equatable.dart';

class TransactionStatus extends Equatable {
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

  const TransactionStatus({
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
