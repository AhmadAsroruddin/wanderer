import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/article_bloc.dart';
import '../../shared/theme.dart';

// ignore: must_be_immutable
class SearchBarHome extends StatelessWidget {
  SearchBarHome({
    this.isArticle = false,
    super.key,
  });

  bool isArticle;

  @override
  Widget build(BuildContext context) {
    TextEditingController key = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(
          horizontal: isArticle ? deviceWidth * 0.00 : deviceWidth * 0.04),
      width: deviceWidth * 0.97,
      height: deviceHeight * 0.055,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: isArticle ? Border.all(width: 0.5) : null,
        color: Colors.white, // Ubah ke warna yang Anda inginkan
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: key,
              decoration: InputDecoration(
                prefixIcon: GestureDetector(
                  onTap: () {
                    context.read<ArticleCubit>().getArticle(true, key.text);
                  },
                  child: Image.asset(
                    "assets/img/loopSearch.png",
                    scale: 2,
                  ),
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
        ],
      ),
    );
  }
}
