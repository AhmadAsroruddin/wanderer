import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:wanderer/domain/entities/admin.dart';

class AdminModel extends Equatable {
  const AdminModel(
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

  final String id;
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
  final String userId;
  final String nameRek;
  final String aliasNameRek;
  final String emailRek;
  final String bankRek;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'noRek': noRek,
      'address': address,
      'email': email,
      'image': image,
      'noTelp': noTelp,
      'instagram': instagram,
      'website': website,
      'tiktok': tiktok,
      'facilities': facilities,
      'time': time,
      'category': category,
      'latitude': latitude,
      'longitude': longitude,
      'markerId': markerId,
      'description': description,
      'nameRek': nameRek,
      'aliasRek': aliasNameRek,
      'emailRek': emailRek,
      'bankRek': bankRek
    };
  }

  static Admin fromMap(Map<String, dynamic> data) {
    return Admin(
        id: data['id'],
        name: data['name'],
        userId: data['userId'],
        noRek: data['noRek'],
        address: data['address'],
        email: data['email'],
        image: data['image'],
        noTelp: data['noTelp'],
        tiktok: data['tiktok'],
        website: data['website'],
        instagram: data['instagram'],
        facilities: data['facilities'],
        time: data['time'],
        description: data['description'],
        category: data['category'],
        latitude: data['latitude'],
        longitude: data['longitude'],
        markerId: data['markerId'],
        nameRek: data['nameRek'],
        aliasNameRek: data['aliasNameRek'],
        bankRek: data['bankRek'],
        emailRek: data['emailRek']);
  }

  factory AdminModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return AdminModel(
        id: data['id'],
        userId: data['userId'],
        name: data['name'],
        noRek: data['noRek'],
        address: data['address'],
        email: data['email'],
        image: data['image'],
        noTelp: data['noTelp'],
        tiktok: data['tiktok'],
        website: data['website'],
        instagram: data['instagram'],
        facilities: data['facilities'],
        time: data['time'],
        description: data['description'],
        category: data['category'],
        latitude: data['latitude'],
        longitude: data['longitude'],
        markerId: data['markerId'],
        nameRek: data['nameRek'],
        aliasNameRek: data['aliasRek'],
        bankRek: data['bankRek'],
        emailRek: data['emailRek']);
  }
  Admin toEntity() {
    return Admin(
        id: id,
        userId: userId,
        name: name,
        noRek: noRek,
        address: address,
        email: email,
        image: image,
        noTelp: noTelp,
        website: website,
        tiktok: tiktok,
        instagram: instagram,
        facilities: facilities,
        time: time,
        description: description,
        category: category,
        latitude: latitude,
        longitude: longitude,
        markerId: markerId,
        nameRek: nameRek,
        aliasNameRek: aliasNameRek,
        bankRek: bankRek,
        emailRek: emailRek);
  }

  @override
  List<Object> get props => [
        id,
        userId,
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
        category,
        latitude,
        longitude,
        markerId,
        nameRek,
        bankRek,
        aliasNameRek,
        emailRek
      ];
}
