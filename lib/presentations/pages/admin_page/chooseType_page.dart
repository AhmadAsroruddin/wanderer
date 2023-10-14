import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderer/presentations/bloc/admin_bloc.dart';

import '../../shared/theme.dart';

class ChooseTypePage extends StatelessWidget {
  const ChooseTypePage({super.key});

  static const routeName = 'chooseTypePage';

  @override
  Widget build(BuildContext context) {
    String cat = context.read<AdminCubit>().getCategory();
    print(cat);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Back",
          style: blackTextStyle,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
          child: Column(
            children: <Widget>[
              Text(
                "Mana yang mendeskripsikan tempat anda?",
                style: GoogleFonts.roboto().copyWith(
                  fontSize: deviceWidth * 0.06,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              Container(
                width: deviceWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Container(
                      margin: EdgeInsets.only(bottom: deviceHeight * 0.005),
                      child: Text(
                        "Perkemahan",
                        style: GoogleFonts.roboto().copyWith(
                          fontSize: deviceWidth * 0.05,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      "Tempat hanya untuk kemah di tenda bawah",
                      style: TextStyle(
                        fontSize: deviceWidth * 0.035,
                      ),
                    ),
                    trailing: Image.asset("assets/admin/campsite.png"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
