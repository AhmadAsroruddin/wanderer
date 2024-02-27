import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/shared/search_page.dart';

import '../../bloc/admin_data_bloc.dart';
import '../../bloc/article_bloc.dart';
import '../../shared/theme.dart';

// ignore: must_be_immutable
class SearchBarHome extends StatefulWidget {
  SearchBarHome({
    this.isCamper = false,
    this.isHomePage = false,
    this.isSearchPage = false,
    this.isArticle = false,
    super.key,
  });

  bool isCamper;
  bool isHomePage;
  bool isSearchPage;
  bool isArticle;

  @override
  State<SearchBarHome> createState() => _SearchBarHomeState();
}

class _SearchBarHomeState extends State<SearchBarHome> {
  TextEditingController value = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(deviceWidth * 0.02),
      margin: EdgeInsets.symmetric(
        horizontal: widget.isCamper ? deviceWidth * 0.00 : deviceWidth * 0.04,
      ),
      width: deviceWidth * 0.97,
      height: deviceHeight * 0.06,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: widget.isCamper ? Border.all(width: 0.5) : null,
          color: Colors.white, // Ubah ke warna yang Anda inginkan
          boxShadow: const [
            BoxShadow(
              color: Colors.grey, // Warna bayangan
              blurRadius: 2.0, // Mengatur kabur bayangan (bayangan tipis)
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          widget.isSearchPage == true
              ? Container()
              : Image.asset(
                  "assets/img/list.png",
                  scale: 1.8,
                ),
          SizedBox(
            width: deviceWidth * 0.01,
          ),
          Expanded(
            child: Center(
              child: TextFormField(
                controller: value,
                onTap: () {
                  if (widget.isHomePage == true) {
                    Navigator.of(context).pushNamed(SearchPage.routeName);
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: GestureDetector(
                    onTap: () {
                      if (widget.isHomePage == true) {
                        context.read<MarkersCubit>().searchMarker(value.text);
                      } else if (widget.isCamper == true) {
                        context
                            .read<AdminDataCubit>()
                            .getAllAdminCampervan(true, value.text);
                      } else if (widget.isSearchPage == true) {
                        context.read<MarkersCubit>().searchMarker(value.text);
                      } else if (widget.isArticle == true) {
                        context
                            .read<ArticleCubit>()
                            .getArticle(true, value.text);
                      }
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
          ),
          SizedBox(
            width: deviceWidth * 0.03,
          ),
          GestureDetector(
            onTap: () async {},
            child: Image.asset(
              widget.isCamper
                  ? "assets/img/marker.png"
                  : "assets/img/filter.png",
              scale: 1,
            ),
          ),
        ],
      ),
    );
  }
}
