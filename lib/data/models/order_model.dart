import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/order.dart';

class OrderDataModel extends Equatable {
  const OrderDataModel({
    required this.id,
    required this.accountId,
    required this.guestName,
    required this.orderedPlaceId,
    required this.firstDate,
    required this.lastDate,
    required this.days,
    required this.price,
    required this.status,
    required this.message,
    required this.amountType,
    required this.name,
    required this.orderId,
  });

  final String id;
  final String orderedPlaceId; //Campervan or campsite where they order
  final String accountId;
  final String guestName;
  final String firstDate;
  final String lastDate;
  final int days;
  final double price;
  final String status;
  final String message;
  final String name;
  final int amountType;
  final String orderId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'guestName': guestName,
      'accountId': accountId,
      'orderedPlaceId': orderedPlaceId,
      'firstDate': firstDate,
      'lastDate': lastDate,
      'days': days,
      'price': price,
      'status': status,
      'message': message,
      'amountType': amountType,
      'name': name,
      'orderId': orderId,
      'timeStamp': FieldValue.serverTimestamp()
    };
  }

  OrderData fromMap(Map<String, dynamic> map) {
    return OrderData(
        id: map['id'],
        accountId: map['accountId'],
        guestName: map['guestName'],
        orderedPlaceId: map['orderedPlaceId'],
        firstDate: map['firstDate'],
        lastDate: map['lastDate'],
        days: map['days'],
        price: map['price'],
        status: map['status'],
        message: map['message'],
        amountType: map['amountType'],
        name: map['name'],
        orderId: map['orderId']);
  }

  factory OrderDataModel.getFromDocumentSnapshhot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return OrderDataModel(
      id: data['id'],
      accountId: data['accountId'],
      guestName: data['guestName'],
      orderedPlaceId: data['orderedPlaceId'],
      firstDate: data['firstDate'],
      lastDate: data['lastDate'],
      days: data['days'],
      price: data['price'],
      status: data['status'],
      message: data['message'],
      name: data['name'],
      amountType: data['amountType'],
      orderId: data['orderId'],
    );
  }

  OrderData toEntity() {
    return OrderData(
        id: id,
        accountId: accountId,
        guestName: guestName,
        orderedPlaceId: orderedPlaceId,
        firstDate: firstDate,
        lastDate: lastDate,
        days: days,
        price: price,
        status: status,
        message: message,
        amountType: amountType,
        name: name,
        orderId: orderId);
  }

  @override
  List<Object> get props => [
        id,
        accountId,
        guestName,
        orderedPlaceId,
        firstDate,
        lastDate,
        days,
        price,
        status,
        message,
        amountType,
        name,
        orderId,
      ];
}
