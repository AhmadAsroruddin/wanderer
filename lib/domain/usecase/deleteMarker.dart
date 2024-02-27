import 'package:wanderer/domain/repositories/marker_repository.dart';

class DeleteMarker {
  MarkerRepos markerRepos;

  DeleteMarker({required this.markerRepos});

  Future<void> deleteMarker(String markerId) async {
    await markerRepos.deleteMarker(markerId);
  }
}
