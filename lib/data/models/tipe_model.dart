import 'package:equatable/equatable.dart';
import 'package:wanderer/domain/entities/tipe.dart';

class TipeModel extends Equatable {
  const TipeModel({
    required this.name,
    required this.price,
    required this.facility,
    required this.images,
    required this.capacity,
    required this.description,
  });

  final String name;
  final double price;
  final List<String> facility;
  final List<dynamic> images;
  final int capacity;
  final String description;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'facility': facility,
      'images': images,
      'capacity': capacity,
      'description': description
    };
  }

  static Tipe fromMap(Map<String, dynamic> data) {
    return Tipe(
      name: data['name'],
      price: data['price'],
      facility: data['facility'],
      images: data['images'],
      capacity: data['capacity'],
      description: data['description'],
    );
  }

  Tipe toEntity() {
    return Tipe(
      name: name,
      price: price,
      facility: facility,
      images: images,
      capacity: capacity,
      description: description,
    );
  }

  @override
  List<Object> get props =>
      [name, price, facility, images, capacity, description];
}
