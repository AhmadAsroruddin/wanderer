import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShareComponent extends StatelessWidget {
  final String img;
  final String label;
  final VoidCallback? onPressed;

  const ShareComponent({super.key, required this.img, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          child: Column(children: <Widget>[
        Image.asset(
          img,
          height: 30,
          width: 30,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.roboto(fontSize: 15),
        )
      ])),
    );
  }
}
