import 'package:equatable/equatable.dart';

class Admin extends Equatable {
  const Admin({required this.name, required this.price, required this.address});

  final String name;
  final double price;
  final String address;

  @override
  List<Object> get props => [name, price, address];
}
