import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/domain/repositories/marker_repository.dart';

import '../entities/marker.dart';

class AddMarkers {
  final MarkerRepos markerRepos;

  AddMarkers({required this.markerRepos});

  Future<Either<String, String>> execute(Markers markers, List<XFile> images,
      bool adminCheck, List<dynamic> link) {
    return markerRepos.addMarker(markers, images, adminCheck, link);
  }
}
