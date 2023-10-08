import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../entities/marker.dart';

abstract class MarkerRepos {
  Future<Either<String, String>> addMarker(Markers markers, List<XFile> images);
  Future<List<Markers>> getAllMarkers();
  Future<Either<String, String>> addAdmin(
      String name, double price, String address);
}
