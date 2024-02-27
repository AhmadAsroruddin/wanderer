import 'package:wanderer/data/models/marker_model.dart';
import 'package:wanderer/domain/repositories/marker_repository.dart';

class GetUserMarker {
  MarkerRepos markerRepos;

  GetUserMarker({required this.markerRepos});

  Future<List<MarkerModel>> execute(List<dynamic> markersId) async {
    return await markerRepos.getUserMarker(markersId);
  }
}
