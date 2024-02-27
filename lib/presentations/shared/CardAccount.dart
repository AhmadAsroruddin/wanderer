import 'package:flutter/material.dart';

import 'theme.dart';

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
            color: Colors.white,
          ),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: blackTextStyle.copyWith(
                    fontSize: deviceWidth * 0.04, fontWeight: bold),
              ),
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
