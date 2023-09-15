import 'package:flutter/material.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({
    required this.name,
    super.key,
  });

  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromRGBO(255, 248, 248, 1),
      ),
      child: Row(
        children: [
          Text(
            name,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
          Image.asset("assets/img/dropDown.png")
        ],
      ),
    );
  }
}
