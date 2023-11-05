import 'package:flutter/material.dart';
import 'package:wanderer/presentations/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'component_modal_share.dart';

class ModalShare extends StatelessWidget {
  final String title;

  const ModalShare({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const FractionalOffset(0.5, 0.85),
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 250,
            width: deviceWidth - 50,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        title,
                        style: GoogleFonts.roboto(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        ShareComponent(
                          img: 'assets/modal/whatsapp_logo.jpg',
                          label: 'Whatsapp',
                        ),
                        SizedBox(width: 40),
                        ShareComponent(
                          img: 'assets/modal/line_logo.jpg',
                          label: 'Line',
                        ),
                        SizedBox(width: 40),
                        ShareComponent(
                          img: 'assets/modal/instagram_logo.jpg',
                          label: 'Instagram',
                        ),
                        SizedBox(width: 40),
                        ShareComponent(
                          img: 'assets/modal/facebook_logo.png',
                          label: 'Facebook',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        ShareComponent(
                          img: 'assets/modal/x_logo.jpg',
                          label: 'X / Twitter',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 200,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: const Center(child: Text("Cancel")),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
