import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/data/datasource/markers_datasource.dart';
import 'package:wanderer/data/models/marker_model.dart';
import 'package:wanderer/domain/entities/marker.dart';
import 'package:wanderer/domain/repositories/marker_repository.dart';

class MarkersReposImpl implements MarkerRepos {
  final MarkersDataSource markersDataSource;
  final FirebaseFirestore firebaseFirestore;

  MarkersReposImpl(
      {required this.markersDataSource, required this.firebaseFirestore});

  @override
  Future<Either<String, String>> addMarker(Markers markers, List<XFile> images,
      bool adminCheck, List<dynamic> link) async {
    try {
      await markersDataSource.addMarker(markers, images);

      return const Right("Marker berhasil ditambahkan");
    } catch (e) {
      return Left("error : $e");
    }
  }

  @override
  Future<List<Markers>> getAllMarkers() async {
    final QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('markers').get();

    final List<Markers> markers = querySnapshot.docs
        .map<Markers>((doc) => MarkerModel.fromDocumentSnapshot(doc).toEntity())
        .toList();

    return markers;
  }

  @override
  Future<Either<String, String>> addAdmin(
      String name, double price, String address) {
    // TODO: implement addAdmin
    throw UnimplementedError();
  }

  @override
  Future<String> addMarkerAdmin(Markers markers, link) async {
    try {
      String markerId = await markersDataSource.addMarkerAdmin(markers, link);
      return markerId;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<void> updateUserId(String id, String markerId) async {
    try {
      await markersDataSource.updateUserId(id, markerId);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Markers> getOneMarker(String markerId) async {
    return await markersDataSource.getMarker(markerId);
  }
}
