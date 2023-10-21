import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:wanderer/data/models/order_model.dart';
import 'package:wanderer/domain/entities/order.dart';

abstract class OrderDataSource {
  Future<void> makeOrder(OrderData order);
  Future<List<OrderData>> getOrderDataByStatus(
      String adminId, String status, bool isUser);
  Future<void> updateStatus(String orderId, String adminId, String status);
}

class OrderDataSourceImpl implements OrderDataSource {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<void> makeOrder(OrderData order) async {
    OrderDataModel data = OrderDataModel(
        id: order.id,
        accountId: order.accountId,
        guestName: order.guestName,
        orderedPlaceId: order.orderedPlaceId,
        firstDate: order.firstDate,
        lastDate: order.lastDate,
        days: order.days,
        price: order.price,
        status: order.status,
        message: order.message,
        name: order.name,
        amountType: order.amountType,
        orderId: order.orderId);

    final orderRequest = await firebaseFirestore
        .collection('admin')
        .doc(order.orderedPlaceId)
        .collection('order list')
        .add(data.toMap());

    String orderId = orderRequest.id;

    await firebaseFirestore
        .collection('order list')
        .doc(orderId)
        .set(data.toMap());

    await firebaseFirestore
        .collection("admin")
        .doc(order.orderedPlaceId)
        .collection('order list')
        .doc(orderId)
        .update({'id': orderId});

    await firebaseFirestore
        .collection('order list')
        .doc(orderId)
        .update({'id': orderId});
  }

  @override
  Future<List<OrderData>> getOrderDataByStatus(
      String adminId, String status, bool isUser) async {
    final QuerySnapshot<Map<String, dynamic>> dataQuery;

    if (isUser == false) {
      dataQuery = await firebaseFirestore
          .collection('admin')
          .doc(adminId)
          .collection('order list')
          .where('status', isEqualTo: status)
          .get();
    } else {
      dataQuery = await firebaseFirestore
          .collection('order list')
          .where('accountId', isEqualTo: adminId)
          .where('status', isEqualTo: status)
          .get();
    }

    List<OrderData> list = dataQuery.docs.map<OrderData>((e) {
      return OrderDataModel.getFromDocumentSnapshhot(e).toEntity();
    }).toList();

    return list;
  }

  @override
  Future<void> updateStatus(
      String orderid, String adminId, String status) async {
    await firebaseFirestore
        .collection('admin')
        .doc(adminId)
        .collection('order list')
        .doc(orderid)
        .update({'status': status});

    await firebaseFirestore
        .collection('order list')
        .doc(orderid)
        .update({'status': status});
  }
}
