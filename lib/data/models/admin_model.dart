import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:wanderer/domain/entities/admin.dart';

class AdminModel extends Equatable {
  const AdminModel(
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
      required this.description,
      required this.category,
      required this.latitude,
      required this.longitude,
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
  final List<dynamic> facilities;
  final String markerId;
  final String time;
  final String description;
  final String category;
  final double latitude;
  final double longitude;

  Map<String, dynamic> toMap() {
    return {
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
      'description': description
    };
  }

  static Admin fromMap(Map<String, dynamic> data) {
    return Admin(
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
        markerId: data['markerId']);
  }

  factory AdminModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return AdminModel(
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
        markerId: data['markerId']);
  }
  Admin toEntity() {
    return Admin(
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
        markerId: markerId);
  }

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
        category,
        latitude,
        longitude,
        markerId
      ];
}
