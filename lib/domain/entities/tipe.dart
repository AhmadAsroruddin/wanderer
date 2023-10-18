import 'package:equatable/equatable.dart';

class Tipe extends Equatable {
  const Tipe(
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

  @override
  List<Object> get props =>
      [name, price, facility, images, capacity, description, adminId];
}
