import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';

class PopUpSelectedMarker extends StatelessWidget {
  const PopUpSelectedMarker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 13,
      left: deviceWidth * 0.02,
      right: deviceWidth * 0.02,
      child: Container(
        width: deviceWidth * 0.9,
        height: deviceHeight * 0.11,
        padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/img/campsite.jpg"),
            ),
            Image.asset(
              "assets/img/lingkaran.png",
              scale: 3,
            ),
            Text(
              "Tebing Watu Mabur",
              style: GoogleFonts.inter().copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
