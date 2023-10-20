import 'package:equatable/equatable.dart';

class OrderData extends Equatable {
  const OrderData(
      {required this.id,
      required this.accountId,
      required this.guestName,
      required this.orderedPlaceId,
      required this.firstDate,
      required this.lastDate,
      required this.days,
      required this.price,
      required this.status,
      required this.message});

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
      ];
}
