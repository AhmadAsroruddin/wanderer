import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderer/domain/entities/marker.dart';
import 'package:wanderer/presentations/pages/marker_page/marker_paget.dart';

import '../../shared/theme.dart';

class PopUpSelectedMarker extends StatelessWidget {
  const PopUpSelectedMarker({
    required this.marker,
    super.key,
  });

  final Markers marker;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 13,
      left: deviceWidth * 0.02,
      right: deviceWidth * 0.02,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(MarkerPage.routeName, arguments: [marker]);
        },
        child: Container(
          width: deviceWidth * 0.9,
          height: deviceHeight * 0.11,
          padding: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey, // Warna bayangan
                offset: Offset(0.0, 0), // Mengatur offset bayangan
                blurRadius: .5, // Mengatur tingkat kabur bayangan
                spreadRadius: .5,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage("assets/gif/loading.gif"),
                  image: NetworkImage(marker.image[0], scale: 1),
                ),
              ),
              SizedBox(
                width: deviceWidth * 0.05,
              ),
              Image.asset(
                "assets/img/lingkaran.png",
                scale: 3,
              ),
              SizedBox(
                width: deviceWidth * 0.1,
              ),
              Text(
                marker.name,
                style: GoogleFonts.inter().copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
