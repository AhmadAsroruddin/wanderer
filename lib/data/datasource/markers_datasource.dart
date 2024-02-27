import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/data/models/marker_model.dart';

import '../../domain/entities/marker.dart';

abstract class MarkersDataSource {
  Future<void> addMarker(Markers markers, List<XFile> images);
  Future<Either<String, String>> addAdmin(
      String name, double price, String address);
  Future<String> addMarkerAdmin(Markers markers, List<dynamic> link);
  Future<void> updateUserId(String id, String markerId);
  Future<Markers> getMarker(String markerId);
  Future<List<Markers>> searchMarker(String key);
  Future<List<MarkerModel>> getUserMarkers(List<dynamic> markersId);
  Future<void> updateMarker(MarkerModel marker);
  Future<void> deleteMarker(String markerId);
}

class MarkersDatasourceImpl implements MarkersDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> addMarker(Markers markers, List<XFile> images) async {
    final currentUser = _firebaseAuth.currentUser!.uid;
    List<String> links = [];

    for (var image in images) {
      final ext = image.path.split('.').last.toLowerCase();

      if (ext != 'jpg' && ext != 'png') {
        throw (Exception("File harus berjenis png atau jpg"));
      }

      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('markers')
          .child('${DateTime.now().millisecondsSinceEpoch}.$ext');
      final File imageFile = File(image.path);
      final UploadTask uploadTask = storageReference.putFile(imageFile);
      final TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);
      final imageURL = await taskSnapshot.ref.getDownloadURL();
      links.add(imageURL);
    }

    final newMarker = await _firestore.collection('markers').add(MarkerModel(
            name: markers.name,
            description: markers.description,
            image: links,
            jenis: markers.jenis,
            latitude: markers.latitude,
            longitude: markers.longitude,
            userId: markers.userId,
            contact: markers.contact,
            socialMedia: markers.socialMedia,
            address: markers.address,
            id: "",
            harga: markers.harga)
        .toMap());

    final newMarkerID = newMarker.id;
    await newMarker.update({'id': newMarkerID});
    await _firestore.collection('users').doc(currentUser).update(
      {
        'markers': FieldValue.arrayUnion([newMarkerID])
      },
    );
    return newMarkerID;
  }

  @override
  Future<Either<String, String>> addAdmin(
      String name, double price, String address) {
    // TODO: implement addAdmin
    throw UnimplementedError();
  }

  @override
  Future<String> addMarkerAdmin(Markers markers, List link) async {
    final currentUser = _firebaseAuth.currentUser!.uid;
    final newMarker = await _firestore.collection('markers').add(MarkerModel(
            name: markers.name,
            description: markers.description,
            image: link,
            jenis: markers.jenis,
            latitude: markers.latitude,
            longitude: markers.longitude,
            userId: markers.userId,
            contact: markers.contact,
            socialMedia: markers.socialMedia,
            address: markers.address,
            id: "",
            harga: markers.harga)
        .toMap());

    final newMarkerID = newMarker.id;
    await newMarker.update({'id': newMarkerID});
    await _firestore.collection('users').doc(currentUser).update(
      {
        'markers': FieldValue.arrayUnion([newMarkerID])
      },
    );
    return newMarkerID;
  }

  @override
  Future<void> updateUserId(String id, String markerId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('markers').doc(markerId).update({'userId': id});
  }

  @override
  Future<Markers> getMarker(String markerId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final adminQuery = await firebaseFirestore
        .collection('markers')
        .where('id', isEqualTo: markerId)
        .get();

    final List<Markers> admin = adminQuery.docs
        .map<Markers>((doc) => MarkerModel.fromDocumentSnapshot(doc).toEntity())
        .toList();

    return admin[0];
  }

  @override
  Future<List<Markers>> searchMarker(String key) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final query = await firestore
        .collection('markers')
        .where('name', isGreaterThanOrEqualTo: key)
        .where('name', isLessThanOrEqualTo: '$key\uf8ff')
        .get();
    final List<Markers> marker = query.docs
        .map<Markers>((e) => MarkerModel.fromDocumentSnapshot(e).toEntity())
        .toList();
    return marker;
  }

  @override
  Future<List<MarkerModel>> getUserMarkers(List<dynamic> markersId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference markersRef = firestore.collection("markers");

    QuerySnapshot querySnapshot =
        await markersRef.where('id', whereIn: markersId).get();

    List<MarkerModel> markers = querySnapshot.docs
        .map((e) => MarkerModel.fromDocumentSnapshot(e))
        .toList();
    return markers;
  }

  @override
  Future<void> updateMarker(MarkerModel marker) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('markers').doc(marker.id).update(marker.toMap());
  }

  @override
  Future<void> deleteMarker(String markerId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('markers').doc(markerId).delete();
  }
}
