import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../entities/marker.dart';

abstract class MarkerRepos {
  Future<Either<String, String>> addMarker(Markers markers, List<XFile> images);
}
