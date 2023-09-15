import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/data/datasource/markers_datasource.dart';
import 'package:wanderer/domain/entities/marker.dart';
import 'package:wanderer/domain/repositories/marker_repository.dart';

class MarkersReposImpl implements MarkerRepos {
  final MarkersDataSource markersDataSource;

  MarkersReposImpl({required this.markersDataSource});

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
}
