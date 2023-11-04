import 'package:wanderer/domain/entities/marker.dart';
import 'package:wanderer/domain/repositories/marker_repository.dart';

class GetMarkerData {
  MarkerRepos markerRepos;

  GetMarkerData({required this.markerRepos});

  Future<Markers> execute(String markerId) async {
    return markerRepos.getOneMarker(markerId);
  }
}
