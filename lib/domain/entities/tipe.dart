import 'package:equatable/equatable.dart';

class Tipe extends Equatable {
  const Tipe({
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

  @override
  List<Object> get props =>
      [name, price, facility, images, capacity, description];
}
