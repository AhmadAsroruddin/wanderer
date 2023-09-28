import 'package:equatable/equatable.dart';

class Markers extends Equatable {
  const Markers(
      {required this.name,
      required this.description,
      required this.image,
      required this.jenis,
      required this.latitude,
      required this.longitude,
      required this.userId,
      required this.contact,
      required this.socialMedia,
      required this.address,
      this.id = "id"});

  final String userId;
  final String jenis;
  final String name;
  final double latitude;
  final double longitude;
  final String description;
  final String contact;
  final String socialMedia;
  final List<dynamic> image;
  final String address;
  final String id;

  @override
  List<Object> get props => [
        name,
        jenis,
        userId,
        latitude,
        longitude,
        description,
        image,
        socialMedia,
        contact,
        address,
        id
      ];
}
