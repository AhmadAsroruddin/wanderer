import 'package:wanderer/domain/repositories/marker_repository.dart';

import '../entities/marker.dart';

class AddMarkerAdmin {
  final MarkerRepos markerRepos;
  AddMarkerAdmin({required this.markerRepos});

  Future<String> execute(Markers markers, List<dynamic> links) async {
    return markerRepos.addMarkerAdmin(markers, links);
  }
}
