import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/shared/search_page.dart';

import '../../bloc/admin_data_bloc.dart';
import '../../shared/theme.dart';

// ignore: must_be_immutable
class SearchBarHome extends StatelessWidget {
  SearchBarHome({
    this.isCamper = false,
    this.isHomePage = false,
    this.isSearchPage = false,
    super.key,
  });

  bool isCamper;
  bool isHomePage;
  bool isSearchPage;

  TextEditingController value = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(
        horizontal: isCamper ? deviceWidth * 0.00 : deviceWidth * 0.04,
      ),
      width: deviceWidth * 0.97,
      height: deviceHeight * 0.055,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: isCamper ? Border.all(width: 0.5) : null,
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
          isSearchPage == true
              ? Container()
              : GestureDetector(
                  onTap: () {
                    _showHalfWidthPopup(context);
                  },
                  child: Image.asset(
                    "assets/img/list.png",
                    scale: 1.8,
                  ),
                ),
          SizedBox(
            width: deviceWidth * 0.01,
          ),
          Expanded(
            child: TextFormField(
              controller: value,
              onTap: () {
                if (isHomePage == true) {
                  Navigator.of(context).pushNamed(SearchPage.routeName);
                }
              },
              decoration: InputDecoration(
                prefixIcon: GestureDetector(
                  onTap: () {
                    if (isHomePage == true) {
                      context.read<MarkersCubit>().searchMarker(value.text);
                    } else if (isCamper == true) {
                      context
                          .read<AdminDataCubit>()
                          .getAllAdminCampervan(true, value.text);
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

  void _showHalfWidthPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Popup Setengah Lebar'),
          content: SizedBox(
            width: deviceWidth,
            height: deviceHeight,
            // Setengah lebar layar
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Menu 1'),
                ),
                ListTile(
                  leading: Icon(Icons.search),
                  title: Text('Menu 2'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Menu 3'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
