import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:wanderer/data/models/order_model.dart';
import 'package:wanderer/domain/entities/order.dart';

abstract class OrderDataSource {
  Future<void> makeOrder(OrderData order);
  Future<List<OrderData>> getOrderDataByStatus(String adminId, String status);
}

class OrderDataSourceImpl implements OrderDataSource {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<void> makeOrder(OrderData order) async {
    final orderRequest = await firebaseFirestore
        .collection('admin')
        .doc(order.orderedPlaceId)
        .collection('order list')
        .add(OrderDataModel(
                id: order.id,
                accountId: order.accountId,
                guestName: order.guestName,
                orderedPlaceId: order.orderedPlaceId,
                firstDate: order.firstDate,
                lastDate: order.lastDate,
                days: order.days,
                price: order.price,
                status: order.status,
                message: order.message)
            .toMap());

    String orderId = orderRequest.id;

    await firebaseFirestore
        .collection('admin')
        .doc(order.orderedPlaceId)
        .collection('order list')
        .doc(orderId)
        .update({'id': orderId});
  }

  @override
  Future<List<OrderData>> getOrderDataByStatus(
      String adminId, String status) async {
    final docs = await firebaseFirestore
        .collection('admin')
        .doc(adminId)
        .collection('order list')
        .where('status', isEqualTo: status)
        .get();

    List<OrderData> list = docs.docs
        .map<OrderData>(
            (e) => OrderDataModel.getFromDocumentSnapshhot(e).toEntity())
        .toList();

    return list;
  }
}
