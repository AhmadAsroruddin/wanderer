import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:wanderer/presentations/bloc/location_data_cubit.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import '../../bloc/toggle_boolean_bloc.dart';

class MapFullPage extends StatefulWidget {
  const MapFullPage({super.key});
  static const routeName = '/MapFullPage';

  @override
  State<MapFullPage> createState() => _MapFullPageState();
}

class _MapFullPageState extends State<MapFullPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> markers = {};
  geo.Placemark? placemark;
  late GoogleMapController mapController;
  final deviceLocation = const LatLng(12, 12);

  LatLng selectedLatLng = const LatLng(12, 12);
  String alamat = "Silahkan Klik Pada Peta";

  @override
  void initState() {
    onMyLocationButtonPress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: true,
              initialCameraPosition: CameraPosition(
                target: deviceLocation,
                zoom: 14,
              ),
              scrollGesturesEnabled: true,
              markers: markers,
              onTap: (argument) {
                onPressMaps(argument);
              },
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
                await _controller.future.then(
                  (value) async {
                    mapController = await _controller.future;
                  },
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: deviceHeight * 0.7,
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(alamat),
                    OutlinedButton(
                      onPressed: () {
                        context
                            .read<LocationDataCubit>()
                            .saveLocationData(selectedLatLng, alamat);
                      },
                      child: const Text("Simpan"),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              top: deviceHeight * 0.4,
              left: deviceWidth * 0.03,
              child: Container(
                width: deviceWidth * 0.12,
                height: deviceHeight * 0.06,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey, // Warna bayangan
                      offset: Offset(0, 2), // Posisi bayangan (x, y)
                      blurRadius: 5.0, // Tingkat blur
                      spreadRadius: 1.0, // Seberapa jauh bayangan menyebar
                    )
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onMyLocationButtonPress() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("Location services is not available");
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("Location permission is denied");
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      placemark = place;
    });

    defineMarker(latLng, street!, address);
    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void defineMarker(LatLng latLng, String street, String address) async {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(title: street, snippet: address),
      onTap: () {
        context.read<BooleanCubit>().toggleValue();
      },
    );

    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  void onPressMaps(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      placemark = place;
      alamat = address;
      selectedLatLng = latLng;
    });

    defineMarker(latLng, street!, address);

    mapController.animateCamera(CameraUpdate.newLatLng(latLng));
  }
}
