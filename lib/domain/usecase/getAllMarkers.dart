import 'package:wanderer/domain/entities/marker.dart';
import 'package:wanderer/domain/repositories/marker_repository.dart';

class GetAllMarkers {
  final MarkerRepos markerRepos;

  GetAllMarkers({required this.markerRepos});

  Future<List<Markers>> execute() {
    return markerRepos.getAllMarkers();
  }
}
