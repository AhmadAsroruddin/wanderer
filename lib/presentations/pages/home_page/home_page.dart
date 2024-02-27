import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/pages/home_page/search_bar.dart';
import 'package:wanderer/presentations/pages/add_marker/marker_category.dart';
import 'package:wanderer/presentations/shared/alertDialog.dart';
import 'package:wanderer/presentations/shared/map.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import 'popup_selected_marker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.isMarkerClicked = false});
  final bool isMarkerClicked;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarkersCubit, MarkersState>(
      listener: (context, state) {
        if (state is GetOneMarker) {
          setState(() {
            toggle = state.isClicked;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Stack(
                children: <Widget>[
                  const GMaps(),
                  Positioned(
                    top: deviceHeight * 0.015,
                    left: 0,
                    right: 0,
                    child: SearchBarHome(
                      isHomePage: true,
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Column(
                      children: <Widget>[
                        FloatingActionButton(
                          onPressed: () async {
                            if (FirebaseAuth.instance.currentUser != null) {
                              Navigator.of(context)
                                  .pushNamed(MarkerCategoryPage.routeName);
                            } else {
                              DialogUtils.alertDialog(
                                  context, "Errorr", "Please Login First");
                            }
                          },
                          heroTag: "zoom-in",
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            "assets/img/add.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (toggle == true && state is GetOneMarker)
                    PopUpSelectedMarker(
                      marker: state.marker,
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
