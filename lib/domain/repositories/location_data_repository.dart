import 'package:wanderer/domain/entities/location_data.dart';

abstract class LocationDataRepos {
  LocationDataa getLocationData();
  void saveLocationData(LocationDataa locationData);
}
