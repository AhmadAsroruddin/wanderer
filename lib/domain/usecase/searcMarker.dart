import 'package:wanderer/domain/repositories/marker_repository.dart';

import '../entities/marker.dart';

class SearchMarker {
  final MarkerRepos markerRepos;

  const SearchMarker({required this.markerRepos});

  Future<List<Markers>> execute(String key) {
    return markerRepos.searchMarker(key);
  }
}
