import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/toggle_boolean_bloc.dart';
import 'package:wanderer/presentations/pages/home_page/search_bar.dart';
import 'package:wanderer/presentations/pages/add_marker/marker_category.dart';
import 'package:wanderer/presentations/shared/map.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import 'popup_selected_marker.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, this.isMarkerClicked = false});
  final bool isMarkerClicked;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BooleanCubit, bool>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Stack(
                children: <Widget>[
                  const GMaps(),
                  Positioned(
                    top: deviceHeight * 0.01,
                    left: 0,
                    right: 0,
                    child: SearchBarHome(),
                  ),
                  Positioned(
                    top: deviceHeight * 0.1,
                    right: 0,
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.my_location,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Column(
                      children: <Widget>[
                        FloatingActionButton(
                          onPressed: () async {
                            Navigator.of(context)
                                .pushNamed(MarkerCategoryPage.routeName);
                          },
                          heroTag: "zoom-in",
                          child: Image.asset(
                            "assets/img/add.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state == true) const PopUpSelectedMarker()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
