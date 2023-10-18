import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color whiteColor = const Color(0xffFFFFFF);
Color blackColor = const Color(0xff14193F);
Color greyColor = const Color(0xffA4A8AE);
Color lightGreyColor = const Color(0xffF1F1F9);
Color lightBackgroundColor = const Color(0xffF6F8FB);
Color darkBackgroundColor = const Color(0xff020518);
Color blueColor = const Color(0xff53C1F9);
Color purpleColor = const Color(0xff5142E6);
Color greenColor = const Color(0xff22B07D);
Color numberBackgroundColor = const Color(0xff1A1D2E);
Color redColor = const Color(0xffFF2566);
Color mainColor = const Color(0x00FFD700);
Color baseColor = const Color.fromRGBO(255, 215, 0, 1);

final double deviceWidth = MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.single)
    .size
    .width;
final double deviceHeight = MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.single)
    .size
    .height;

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: blackColor,
);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: whiteColor,
);

TextStyle greyTextStyle = GoogleFonts.poppins(
  color: greyColor,
);

TextStyle blueTextStyle = GoogleFonts.poppins(
  color: blueColor,
);

TextStyle greenTextStyle = GoogleFonts.poppins(
  color: greenColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

final TextStyle kHeading5 =
    GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400);
final TextStyle kHeading6 = GoogleFonts.poppins(
    fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kSubtitle = GoogleFonts.poppins(
    fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
final TextStyle kBodyText = GoogleFonts.poppins(
    fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);
