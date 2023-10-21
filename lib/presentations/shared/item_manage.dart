import 'package:flutter/material.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class Item extends StatelessWidget {
  const Item({super.key, required this.data, required this.icon});

  final String data;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.008),
      child: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(
            width: deviceWidth * 0.03,
          ),
          Text(
            data,
            style: blackTextStyle.copyWith(
              fontSize: deviceWidth * 0.04,
            ),
          ),
        ],
      ),
    );
  }
}
