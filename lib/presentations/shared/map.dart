import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';

import '../../domain/entities/marker.dart';

class GMaps extends StatefulWidget {
  const GMaps({
    super.key,
  });

  @override
  State<GMaps> createState() => _GMapsState();
}

class _GMapsState extends State<GMaps> {
  final deviceLocation = const LatLng(12, 12);
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  bool isMarkerClicked = false;
  geo.Placemark? placemark;

  @override
  void initState() {
    onMyLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      mapType: MapType.normal,
      markers: markers,
      scrollGesturesEnabled: true,
      initialCameraPosition: CameraPosition(
        target: deviceLocation,
        zoom: 14,
      ),
      onMapCreated: (GoogleMapController controller) async {
        print("fijr");
        _controller.complete(controller);
        await _controller.future.then(
          (value) async {
            mapController = await _controller.future;
          },
        );
        final List<Markers> data =
            await context.read<MarkersCubit>().getAllMarkers();

        for (var datas in data) {
          defineMarker(LatLng(datas.latitude, datas.longitude), "street",
              "address", datas.latitude.toString());
        }
        print(markers.length);
      },
    );
  }

  void onMyLocation() async {
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

    setState(() {
      placemark = place;
    });

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void defineMarker(LatLng latLng, String street, String address, String id) {
    final marker = Marker(
      markerId: MarkerId(id),
      position: latLng,
      infoWindow: InfoWindow(title: street, snippet: address),
      onTap: () async {
        setState(() {
          isMarkerClicked = !isMarkerClicked;
        });
        context.read<MarkersCubit>().toggleValue(isMarkerClicked);
      },
    );

    setState(() {
      markers.add(marker);
    });
  }

  void getAllMarker() {}
}
