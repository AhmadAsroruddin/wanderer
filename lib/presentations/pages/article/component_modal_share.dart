import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShareComponent extends StatelessWidget {
  
  final String img;
  final String label;

  ShareComponent({required this.img, required this.label});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Column(
        children:<Widget>[
          Image.asset(
            this.img,
            height: 30, width: 30,
            fit: BoxFit.cover,
          ),
          SizedBox(height:5),
          Text(
            this.label,
            style:GoogleFonts.roboto(fontSize:15),
          )
        ]
      )
    );
  }
}