import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../entities/marker.dart';

abstract class MarkerRepos {
  Future<Either<String, String>> addMarker(
      Markers markers, List<XFile> images, bool adminCheck, List<dynamic> link);
  Future<List<Markers>> getAllMarkers();
  Future<Either<String, String>> addAdmin(
      String name, double price, String address);
  Future<String> addMarkerAdmin(Markers markers, link);
  Future<void> updateUserId(String id, String markerId);
  Future<Markers> getOneMarker(String markerId);
  Future<List<Markers>> searchMarker(String key);
}
