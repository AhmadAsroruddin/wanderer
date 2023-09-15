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
  Future<Either<String, String>> addMarker(
      Markers markers, List<XFile> images) async {
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
}
