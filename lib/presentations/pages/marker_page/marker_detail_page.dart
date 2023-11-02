import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wanderer/presentations/bloc/admin_data_bloc.dart';
import 'package:wanderer/presentations/bloc/location_data_cubit.dart';

import '../../../domain/entities/marker.dart';
import '../../shared/theme.dart';
import 'marker_paid.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    required this.markers,
    super.key,
  });

  final Markers markers;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  LatLng currLocation = const LatLng(0, 0);
  LatLng destination = const LatLng(1, 1);
  double jarak = 0;
  String adminId = "Asd";

  @override
  void initState() {
    super.initState();

    context.read<AdminDataCubit>().getAdminData(widget.markers.id);
  }

  void _getJarak(LatLng dest) async {
    final Location location = Location();
    LocationData locationData;
    final LatLng curr;

    locationData = await location.getLocation();

    curr = LatLng(locationData.latitude!, locationData.longitude!);

    if (mounted) {
      final distance =
          await context.read<LocationDataCubit>().getDistances(curr, dest);

      setState(() {
        jarak = distance / 1000;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _getJarak(LatLng(widget.markers.latitude, widget.markers.longitude));

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          DetailContainer(
            widget: widget,
            jarak: jarak,
            widgetChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.05,
                      width: deviceWidth * 0.1,
                      child: Image.asset(
                        "assets/img/category/${widget.markers.jenis.toLowerCase()}.png",
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth * 0.02,
                    ),
                    Text(widget.markers.jenis),
                  ],
                ),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Text("${jarak.toStringAsFixed(2)} km dari lokasi anda"),
              ],
            ),
          ),
          DetailContainer(
            widget: widget,
            widgetChild: Text(
              widget.markers.description,
              style: GoogleFonts.inter().copyWith(
                fontSize: 13,
                fontWeight: light,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          if (widget.markers.jenis == "Campervan" ||
              widget.markers.jenis == "Paid_Campsite")
            PaidMarkerPage(
              widget: widget,
              adminId: widget.markers.userId,
            ),
          DetailContainer(
            widget: widget,
            widgetChild: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset("assets/img/marker.png"),
                    SizedBox(
                      width: deviceWidth * 0.05,
                    ),
                    Container(
                        width: deviceWidth * 0.8,
                        child: Text(widget.markers.address)),
                  ],
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: deviceWidth * 0.35,
                    height: deviceHeight * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        width: .5,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final url = Uri.parse(
                            'https://www.google.com/maps/search/?api=1&query=${widget.markers.latitude},${widget.markers.longitude}');

                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'can\'t launch Google Maps';
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("assets/img/direction.png"),
                          const Text("DIRECTIONS"),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          DetailContainer(
            widget: widget,
            widgetChild: Column(
              children: <Widget>[
                ListTile(
                  leading: Image.asset(
                    'assets/img/jam.png',
                    scale: 1.3,
                  ),
                  title: const Text("24 Jam"),
                ),
                if (widget.markers.harga != "")
                  ListTile(
                    leading: Image.asset(
                      'assets/img/harga.png',
                      scale: 1.3,
                    ),
                    title: Text(widget.markers.harga),
                  ),
                if (widget.markers.socialMedia != "")
                  ListTile(
                    leading: Image.asset(
                      "assets/img/instagram.png",
                      scale: 7,
                    ),
                    title: Text(widget.markers.socialMedia),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DetailContainer extends StatelessWidget {
  const DetailContainer(
      {super.key,
      required this.widget,
      this.jarak = 0,
      required this.widgetChild});

  final DetailsPage widget;
  final double jarak;
  final Widget widgetChild;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          vertical: deviceHeight * 0.02,
          horizontal: 5,
        ),
        width: deviceWidth,
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(width: 0.5, color: greyColor),
          ),
        ),
        child: widgetChild);
  }
}
