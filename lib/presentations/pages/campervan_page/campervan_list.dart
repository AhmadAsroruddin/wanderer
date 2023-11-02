import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';

class CampervanList extends StatelessWidget {
  const CampervanList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth,
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(width: 0.2),
        ),
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
          width: deviceWidth * 0.98,
          child: Row(
            children: <Widget>[
              Container(
                width: deviceWidth * 0.3,
                height: deviceHeight * (0.1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage("assets/img/campsite.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: deviceWidth * 0.05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Suzuki APV Arena 2022",
                    style: GoogleFonts.inter().copyWith(
                      fontSize: 14,
                      fontWeight: bold,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        height: deviceHeight * 0.04,
                        width: deviceWidth * 0.45,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return const Icon(
                              Icons.star,
                              color: Colors.amber,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/img/marker.png",
                        scale: 2,
                      ),
                      SizedBox(
                        width: deviceWidth * 0.01,
                      ),
                      const Text(
                        "Sleman, Yogyakarta",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: deviceWidth * 0.03,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_outline),
              )
            ],
          ),
        ),
      ),
    );
  }
}
