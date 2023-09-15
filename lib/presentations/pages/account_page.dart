import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/auth_bloc.dart';
import '../shared/theme.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/img/avatar.png"),
                  radius: 100,
                ),
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                Text(
                  "Juan Ritonga",
                  style: GoogleFonts.roboto().copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                CardAccount(
                  title: "Akun",
                  deviceWidth: deviceWidth,
                  deviceHeight: deviceHeight,
                  child: AccountItem(
                    deviceWidth: deviceWidth,
                    deviceHeight: deviceHeight,
                    name: "Edit Profile",
                    image: "edit",
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                CardAccount(
                  title: "Keperluan",
                  deviceWidth: deviceWidth,
                  deviceHeight: deviceHeight,
                  child: Column(
                    children: <Widget>[
                      AccountItem(
                        deviceWidth: deviceWidth,
                        deviceHeight: deviceHeight,
                        name: "Pesanan Saya",
                        image: "tab_image/order",
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      AccountItem(
                        deviceWidth: deviceWidth,
                        deviceHeight: deviceHeight,
                        name: "Favorite Saya",
                        image: "love",
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.08,
                ),
                const Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: deviceWidth * 0.1,
                        height: deviceHeight * 0.04,
                        child: Image.asset(
                          "assets/img/logout.png",
                        ),
                      ),
                      SizedBox(
                        width: deviceWidth * 0.1,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<AuthCubit>().logout();
                        },
                        child: Text(
                          "Keluar",
                          style: GoogleFonts.roboto().copyWith(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: deviceWidth * 0.1,
                        height: deviceHeight * 0.04,
                        child: Image.asset(
                          "assets/img/trashBin.png",
                        ),
                      ),
                      SizedBox(
                        width: deviceWidth * 0.1,
                      ),
                      Text(
                        "Hapus Akun",
                        style: GoogleFonts.roboto().copyWith(fontSize: 18),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardAccount extends StatelessWidget {
  const CardAccount({
    super.key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.child,
    required this.title,
  });

  final double deviceWidth;
  final double deviceHeight;
  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth * 0.9,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            width: 0.4,
            color: Colors.grey,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title),
              SizedBox(
                height: deviceHeight * 0.005,
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}

class AccountItem extends StatelessWidget {
  const AccountItem(
      {super.key,
      required this.deviceWidth,
      required this.deviceHeight,
      required this.image,
      required this.name});

  final double deviceWidth;
  final double deviceHeight;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: deviceWidth * 0.1,
          height: deviceHeight * 0.04,
          child: Image.asset("assets/img/$image.png"),
        ),
        SizedBox(width: deviceWidth * 0.05),
        SizedBox(
          width: deviceWidth * 0.4,
          child: Text(
            name,
            style: GoogleFonts.roboto().copyWith(
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(width: deviceWidth * 0.15),
        SizedBox(
          height: deviceHeight * 0.04,
          child: Image.asset("assets/img/rightArrow.png"),
        ),
      ],
    );
  }
}
