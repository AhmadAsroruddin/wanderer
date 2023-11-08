import 'package:flutter/material.dart';

import '../../shared/customButton.dart';
import '../../shared/theme.dart';

class GetStartedWidget extends StatelessWidget {
  const GetStartedWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.onTapCallback,
      required this.number});

  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onTapCallback;
  final String number;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(top: deviceHeight * 0.2),
              width: deviceWidth * 0.9,
              height: deviceHeight * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/getStarted/$image.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            "$number/3",
            style: blackTextStyle.copyWith(fontSize: deviceWidth * 0.04),
          ),
          Container(
            margin: EdgeInsets.only(
                top: deviceHeight * 0.03, bottom: deviceHeight * 0.02),
            width: deviceWidth * 0.9,
            child: Text(
              title,
              style: blackTextStyle.copyWith(
                  fontSize: deviceWidth * 0.055, fontWeight: bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
              child: Text(subtitle),
            ),
          ),
          GestureDetector(
            onTap: () {
              onTapCallback();
            },
            child: Container(
              margin: EdgeInsets.only(bottom: deviceHeight * 0.02),
              width: deviceWidth * 0.9,
              child: const CustomButton(name: "Get Started"),
            ),
          )
        ],
      ),
    );
  }
}
