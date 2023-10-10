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
      required this.markerId});

  final String name;
  final String noRek;
  final String address;
  final String email;
  final List<dynamic> image;
  final String noTelp;
  final String website;
  final String instagram;
  final String tiktok;
  final List<String> facilities;
  final String markerId;

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
        markerId
      ];
}
