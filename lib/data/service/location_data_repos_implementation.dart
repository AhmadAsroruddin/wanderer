import 'package:wanderer/domain/entities/location_data.dart';
import 'package:wanderer/domain/repositories/location_data_repository.dart';

class LocationDataReposImpl implements LocationDataRepos {
  LocationDataa? _locationData;

  @override
  LocationDataa getLocationData() {
    return _locationData!;
  }

  @override
  void saveLocationData(LocationDataa location) {
    _locationData = location;
  }
}
