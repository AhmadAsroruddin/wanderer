import 'package:flutter/material.dart';
import 'package:wanderer/presentations/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalTitikTiga extends StatelessWidget {
  const ModalTitikTiga({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 160,
            width: deviceWidth - 50,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border.symmetric(
                          horizontal: BorderSide(width: 0.2),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 7, left: 7),
                            child: Text(
                              'Lebih banyak pilihan',
                              style: GoogleFonts.roboto(fontSize: 25),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            child: const Icon(Icons.close, size: 32),
                          ),
                        ],
                      )),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 10, color: Colors.white),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.asset(
                                'assets/modal/smile_icon.png',
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 8),
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text('Tertarik',
                                    style: GoogleFonts.roboto(fontSize: 25)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Image.asset(
                                  'assets/modal/sad_icon.png',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text('Tidak Tertarik',
                                    style: GoogleFonts.roboto(fontSize: 25)),
                              ),
                            ],
                          ),
                        ],
                      )),
                ]),
          ),
        ),
      ),
    );
  }
}
