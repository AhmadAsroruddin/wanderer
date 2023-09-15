import 'package:flutter/material.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class ButtonAddWidget extends StatelessWidget {
  const ButtonAddWidget({
    required this.name,
    required this.red,
    required this.green,
    required this.blue,
    required this.func,
    super.key,
  });

  final String name;
  final int red;
  final int green;
  final int blue;
  final func;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0.5),
        color: Color.fromRGBO(red, green, blue, 1),
      ),
      child: TextButton(
        onPressed: func,
        style: TextButton.styleFrom(foregroundColor: Colors.black),
        child: Text(name),
      ),
    );
  }
}
