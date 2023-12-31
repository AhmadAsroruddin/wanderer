import 'package:equatable/equatable.dart';

class Admin extends Equatable {
  const Admin(
      {required this.name,
      required this.id,
      required this.userId,
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
      required this.category,
      required this.nameRek,
      required this.aliasNameRek,
      required this.bankRek,
      required this.emailRek});

  final String name;
  final String userId;
  final String id;
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
  final String nameRek;
  final String aliasNameRek;
  final String emailRek;
  final String bankRek;

  @override
  List<Object> get props => [
        name,
        userId,
        id,
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
        category,
        nameRek,
        bankRek,
        aliasNameRek,
        emailRek
      ];
}
