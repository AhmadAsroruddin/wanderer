import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wanderer/domain/entities/marker.dart';

class MarkerModel extends Equatable {
  const MarkerModel(
      {required this.name,
      required this.description,
      required this.image,
      required this.jenis,
      required this.userId,
      required this.latitude,
      required this.longitude,
      required this.contact,
      required this.socialMedia});

  final String userId;
  final String jenis;
  final String name;
  final double latitude;
  final double longitude;
  final String description;
  final List<dynamic> image;
  final String socialMedia;
  final String contact;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'jenis': jenis,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'image': image,
      'socialMedia': socialMedia,
      'contact': contact
    };
  }

  factory MarkerModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return MarkerModel(
      name: data['name'],
      description: data['description'],
      image: data['image'],
      jenis: data['jenis'],
      userId: data['userId'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      contact: data['contact'],
      socialMedia: data['socialMedia'],
    );
  }

  static Markers fromMap(Map<String, dynamic> data) {
    return Markers(
        name: data['name'],
        description: data['description'],
        image: data['image'],
        jenis: data['jenis'],
        latitude: data['latitude'],
        longitude: data['longitude'],
        userId: data['userId'],
        socialMedia: data['socialMedia'],
        contact: data['contacs']);
  }

  Markers toEntity() {
    return Markers(
      name: name,
      description: description,
      image: image,
      jenis: jenis,
      latitude: latitude,
      longitude: longitude,
      userId: userId,
      socialMedia: socialMedia,
      contact: contact,
    );
  }

  @override
  List<Object> get props => [
        name,
        jenis,
        userId,
        latitude,
        longitude,
        description,
        image,
        contact,
        socialMedia
      ];
}
