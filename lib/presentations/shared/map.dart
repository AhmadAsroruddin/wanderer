import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    // addCustom();
    getAllMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      markers: markers,
      scrollGesturesEnabled: true,
      initialCameraPosition: CameraPosition(
        target: deviceLocation,
        zoom: 15,
      ),
      onMapCreated: (GoogleMapController controller) async {
        _controller.complete(controller);
        await _controller.future.then(
          (value) async {
            mapController = await _controller.future;
          },
        );
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

  void getAllMarkers() async {
    final List<Markers> data =
        await context.read<MarkersCubit>().getAllMarkers();

    for (var datas in data) {
      defineMarker(LatLng(datas.latitude, datas.longitude), "street", "address",
          datas.latitude.toString(), datas);
    }
  }

  // void addCustom() {
  //   BitmapDescriptor.fromAssetImage(
  //           const ImageConfiguration(), 'assets/img/pantai.png')
  //       .then(
  //     (icon) {
  //       setState(() {
  //         customIcon = icon;
  //       });
  //     },
  //   );
  // }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void defineMarker(LatLng latLng, String street, String address, String id,
      Markers markerData) async {
    final Uint8List markesrs = await getBytesFromAsset(
        "assets/markers/${markerData.jenis.toLowerCase()}.png", 300);

    final marker = Marker(
      markerId: MarkerId(id),
      position: latLng,
      icon: BitmapDescriptor.fromBytes(markesrs),
      onTap: () async {
        setState(() {
          isMarkerClicked = !isMarkerClicked;
        });
        context.read<MarkersCubit>().getMarker(isMarkerClicked, markerData);
      },
    );

    setState(() {
      markers.add(marker);
    });
  }
}
