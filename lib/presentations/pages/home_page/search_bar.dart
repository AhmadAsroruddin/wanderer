import 'package:flutter/material.dart';

import '../../shared/theme.dart';

// ignore: must_be_immutable
class SearchBarHome extends StatelessWidget {
  SearchBarHome({
    this.isCamper = false,
    super.key,
  });

  bool isCamper;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(
          horizontal: isCamper ? deviceWidth * 0.00 : deviceWidth * 0.04),
      width: deviceWidth * 0.97,
      height: deviceHeight * 0.055,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: isCamper ? Border.all(width: 0.5) : null,
        color: Colors.white, // Ubah ke warna yang Anda inginkan
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            "assets/img/list.png",
            scale: 1.8,
          ),
          SizedBox(
            width: deviceWidth * 0.01,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Image.asset(
                  "assets/img/loopSearch.png",
                  scale: 2,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: greyColor,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: greyColor),
                ),
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            ),
          ),
          SizedBox(
            width: deviceWidth * 0.03,
          ),
          Image.asset(
            isCamper ? "assets/img/marker.png" : "assets/img/filter.png",
            scale: 1,
          ),
        ],
      ),
    );
  }
}
