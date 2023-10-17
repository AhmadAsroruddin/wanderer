import 'package:equatable/equatable.dart';

class Admin extends Equatable {
  const Admin(
      {required this.name,
      required this.noRek,
      required this.address,
      required this.email,
      required this.image,
      required this.noTelp,
      required this.instagram,
      required this.tiktok,
      required this.website,
      required this.facilities,
      required this.time,
      required this.markerId,
      required this.description,
      required this.latitude,
      required this.longitude,
      required this.category});

  final String name;
  final String noRek;
  final String address;
  final String email;
  final List<dynamic> image;
  final String noTelp;
  final String website;
  final String instagram;
  final String tiktok;
  final List<dynamic> facilities;
  final String markerId;
  final String time;
  final String description;
  final String category;
  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [
        name,
        noRek,
        address,
        email,
        image,
        noTelp,
        website,
        instagram,
        tiktok,
        facilities,
        time,
        description,
        markerId,
        latitude,
        longitude,
        category
      ];
}
