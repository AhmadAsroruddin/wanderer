import 'package:flutter/material.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth,
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
    );
  }
}
