import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wanderer/domain/entities/location_data.dart';
import 'package:wanderer/domain/repositories/location_data_repository.dart';
import 'package:geolocator/geolocator.dart';

class LocationDataCubit extends Cubit<LocationDataa> {
  final LocationDataRepos repository;

  LocationDataCubit(this.repository)
      : super(LocationDataa(alamat: "", latLng: const LatLng(0, 0)));

  void saveLocationData(LatLng latLng, String address) {
    final LocationDataa locationData =
        LocationDataa(alamat: address, latLng: latLng);
    repository.saveLocationData(locationData);
    emit(locationData);
  }

  void loadLocationData() {
    emit(repository.getLocationData());
  }

  Future<double> getDistances(LatLng currLocation, LatLng destinastion) async {
    final double distance = Geolocator.distanceBetween(currLocation.latitude,
        currLocation.longitude, destinastion.latitude, destinastion.longitude);

    return distance;
  }
}
