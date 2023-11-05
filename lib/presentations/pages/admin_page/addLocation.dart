import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:wanderer/presentations/bloc/admin_bloc.dart';
import 'package:wanderer/presentations/pages/admin_page/location_details_page.dart';
import 'package:wanderer/presentations/shared/customButton.dart';

import '../../bloc/toggle_boolean_bloc.dart';
import '../../shared/theme.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});
  static const routeName = '/addLocation';
  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  TextEditingController controller = TextEditingController();
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final deviceLocation = const LatLng(12, 12);
  geo.Placemark? placemark;
  final Set<Marker> markers = {};
  LatLng selectedLatLng = const LatLng(12, 12);
  String alamat = "Silahkan Klik Pada Peta";
  String initial = "";

  @override
  void initState() {
    onMyLocationButtonPress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kembali",
          style: blackTextStyle,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: deviceHeight * 0.02),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.05,
                      vertical: deviceHeight * 0.02),
                  child: Text(
                    "Where`s your place located?",
                    style: GoogleFonts.roboto().copyWith(
                      fontSize: deviceWidth * 0.06,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
                  child: const Text(
                    "Your address is only shared with guests after they have made reservation.",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: deviceWidth,
                  height: deviceHeight * 0.65,
                  child: Stack(
                    children: <Widget>[
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: deviceLocation,
                          zoom: 14,
                        ),
                        markers: markers,
                        onMapCreated: (GoogleMapController controller) async {
                          _controller.complete(controller);
                          await _controller.future.then(
                            (value) async {
                              mapController = await _controller.future;
                            },
                          );
                        },
                        onTap: (argument) {
                          onPressMaps(argument);
                        },
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: deviceWidth * 0.8,
                          height: deviceHeight * 0.05,
                          margin: EdgeInsets.only(top: deviceHeight * 0.01),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey, // Warna bayangan
                                offset: Offset(0,
                                    2), // Geser bayangan secara horizontal dan vertikal
                                blurRadius: 4.0, // Radius blur bayangan
                                spreadRadius:
                                    0.0, // Seberapa jauh bayangan tersebar
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                              border:
                                  InputBorder.none, // Menghilangkan garis bawah
                              hintText:
                                  'Masukkan teks di sini', // Contoh hint text
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  alamat = value;
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                GestureDetector(
                  onTap: () async {
                    context.read<AdminCubit>().setAddress(alamat);
                    context.read<AdminCubit>().setLatLng(
                        selectedLatLng.latitude, selectedLatLng.longitude);
                    Navigator.of(context)
                        .pushNamed(LocationDetailsPage.routeName);
                  },
                  child: SizedBox(
                    width: deviceWidth * 0.8,
                    child: const CustomButton(name: "Next"),
                  ),
                )
              ],
            ),
          ),
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
      alamat = address;
      selectedLatLng = LatLng(locationData.latitude!, locationData.longitude!);
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
      controller = TextEditingController(text: address);
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
