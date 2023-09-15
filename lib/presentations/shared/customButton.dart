import 'package:flutter/material.dart';
import 'package:wanderer/presentations/shared/utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: deviceHeight * 0.05,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 215, 0, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          name,
          style: SafeGoogleFont(
            'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.2125,
            color: const Color(0xff000000),
          ),
        ),
      ),
    );
  }
}
