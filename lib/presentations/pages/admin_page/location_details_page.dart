import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderer/presentations/bloc/admin_bloc.dart';

import 'package:wanderer/presentations/pages/admin_page/step2_page.dart';
import 'package:wanderer/presentations/shared/customButton.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class LocationDetailsPage extends StatelessWidget {
  const LocationDetailsPage({super.key});
  static const routeName = '/locationDetailsPage';
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController rekening = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController time = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();
    TextEditingController website = TextEditingController();
    TextEditingController instagram = TextEditingController();
    TextEditingController description = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Back",
          style: blackTextStyle,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: deviceHeight * 0.02,
              left: deviceWidth * 0.02,
              right: deviceWidth * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Location Details",
                  style: GoogleFonts.roboto().copyWith(
                    fontSize: deviceWidth * 0.05,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Text(
                  "Provide some information about the place you'd like to add.",
                  style: GoogleFonts.roboto().copyWith(
                    fontSize: deviceWidth * 0.035,
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                CustomTextField(
                  hintText: "Nama tempat (Wajib)",
                  controller: name,
                  onChanged: (data) {
                    context.read<AdminCubit>().setName(name.text);
                  },
                ),
                CustomTextField(
                  hintText: "Nomor Rekening (Wajib)",
                  controller: rekening,
                  onChanged: (data) {
                    context.read<AdminCubit>().setNoRek(rekening.text);
                  },
                ),
                CustomTextField(
                  hintText: "Email (wajib)",
                  controller: email,
                  onChanged: (data) {
                    context.read<AdminCubit>().setEmail(email.text);
                  },
                ),
                Text(
                  "Jam",
                  style: TextStyle(fontSize: deviceWidth * 0.04),
                ),
                CustomTextField(
                  hintText: "Jam Operasional (contoh : 14.00 - 21.00)",
                  controller: time,
                  onChanged: (data) {
                    context.read<AdminCubit>().setTime(time.text);
                  },
                ),
                Text(
                  "Contact",
                  style: TextStyle(fontSize: deviceWidth * 0.04),
                ),
                CustomTextField(
                  hintText: "Nomor Handphone",
                  controller: phoneNumber,
                  onChanged: (data) {
                    context.read<AdminCubit>().setNoTelp(phoneNumber.text);
                  },
                ),
                CustomTextField(
                  hintText: "Website",
                  controller: website,
                  onChanged: (data) {
                    context.read<AdminCubit>().setWebsite(website.text);
                  },
                ),
                CustomTextField(
                  hintText: "Instagram",
                  controller: instagram,
                  onChanged: (data) {
                    context.read<AdminCubit>().setInstagram(instagram.text);
                  },
                ),
                Text(
                  "Descriptions",
                  style: TextStyle(fontSize: deviceWidth * 0.04),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: deviceHeight * 0.02),
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0.5),
                  ),
                  child: TextField(
                    controller: description,
                    onChanged: (e) {
                      context.read<AdminCubit>().setDescription(e);
                    },
                    maxLines: 6,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Tulisakan deskripsi mengenai tempat kalian",
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(Step2Page.routeName);
                  },
                  child: const CustomButton(name: "Next"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.hintText,
    required this.controller,
    required this.onChanged,
    super.key,
  });

  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: deviceHeight * 0.02),
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5),
      ),
      child: TextField(
        onChanged: (data) {
          onChanged(data);
        },
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
