import 'package:flutter/material.dart';

import 'utils.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.screenSize,
      required this.hintText,
      required this.icon,
      required this.label,
      this.obscureText = false,
      required this.controller});

  final Size screenSize;
  final String label;
  final String hintText;
  final Icon icon;
  bool obscureText;
  TextEditingController controller;

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
          height: screenSize.height * 0.06,
          width: double.infinity,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: SafeGoogleFont(
                'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.2125,
                color: const Color(0xff636363),
              ),
              prefixIcon: icon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
