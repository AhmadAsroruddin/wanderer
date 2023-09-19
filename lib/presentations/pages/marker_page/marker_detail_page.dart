import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wanderer/presentations/bloc/location_data_cubit.dart';

import '../../../domain/entities/marker.dart';
import '../../shared/theme.dart';

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
  LatLng currLocation = LatLng(0, 0);
  LatLng destination = LatLng(1, 1);
  double jarak = 0;

  @override
  void initState() {
    _getJarak(LatLng(widget.markers.latitude, widget.markers.longitude));
    super.initState();
  }

  void _getJarak(LatLng dest) async {
    final Location location = Location();
    LocationData locationData;
    final curr;

    locationData = await location.getLocation();

    curr = LatLng(locationData.latitude!, locationData.longitude!);

    final distance =
        await context.read<LocationDataCubit>().getDistances(curr, dest);
    setState(() {
      jarak = distance / 1000;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    const Icon(FontAwesomeIcons.tent),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DetailContainer(
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
                    Text(widget.markers.address),
                  ],
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: deviceWidth * 0.3,
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
