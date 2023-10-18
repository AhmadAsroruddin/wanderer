import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:wanderer/domain/entities/tipe.dart';

class TipeModel extends Equatable {
  const TipeModel(
      {required this.name,
      required this.price,
      required this.facility,
      required this.images,
      required this.capacity,
      required this.description,
      required this.adminId});

  final String name;
  final double price;
  final List<dynamic> facility;
  final List<dynamic> images;
  final int capacity;
  final String description;
  final String adminId;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'facility': facility,
      'images': images,
      'capacity': capacity,
      'description': description,
      'adminId': adminId
    };
  }

  factory TipeModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return TipeModel(
        name: data['name'],
        price: data['price'],
        facility: data['facility'],
        images: data['images'],
        capacity: data['capacity'],
        description: data['description'],
        adminId: data['adminId']);
  }

  static Tipe fromMap(Map<String, dynamic> data) {
    return Tipe(
        name: data['name'],
        price: data['price'],
        facility: data['facility'],
        images: data['images'],
        capacity: data['capacity'],
        description: data['description'],
        adminId: data['adminId']);
  }

  Tipe toEntity() {
    return Tipe(
        name: name,
        price: price,
        facility: facility,
        images: images,
        capacity: capacity,
        description: description,
        adminId: adminId);
  }

  @override
  List<Object> get props =>
      [name, price, facility, images, capacity, description, adminId];
}
