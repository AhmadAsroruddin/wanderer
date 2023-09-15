import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderer/presentations/pages/home_page/search_bar.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import 'campervan_list.dart';
import 'filter_box.dart';

class CampervanPage extends StatelessWidget {
  const CampervanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: deviceHeight * 0.02,
                  ),
                  Center(
                    child: SearchBarHome(
                      isCamper: true,
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.01,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FilterBox(
                        name: "Terdekat",
                      ),
                      FilterBox(
                        name: "Harga",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: deviceHeight * 0.01,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "27 Result Found",
                      style: GoogleFonts.inter().copyWith(fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const CampervanList();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
