import 'package:wanderer/domain/repositories/marker_repository.dart';

class UpdateUseridMarker {
  MarkerRepos markerRepos;

  UpdateUseridMarker({required this.markerRepos});

  Future<void> execute(String id, String markerId) async {
    markerRepos.updateUserId(id, markerId);
  }
}
