import 'package:wanderer/data/models/marker_model.dart';
import 'package:wanderer/domain/repositories/marker_repository.dart';

class UpdateMarker {
  MarkerRepos markerRepos;

  UpdateMarker({required this.markerRepos});

  Future<void> execute(MarkerModel markerModel) async {
    await markerRepos.updateMarker(markerModel);
  }
}
