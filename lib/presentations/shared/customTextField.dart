import 'package:flutter/material.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import 'utils.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({required this.label, required this.child});

  Widget child;
  String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: SafeGoogleFont(
            'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.2125,
            color: const Color(0xff000000),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: deviceHeight * 0.06, width: double.infinity, child: child),
      ],
    );
  }
}
