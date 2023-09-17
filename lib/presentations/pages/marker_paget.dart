import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import '../../domain/entities/marker.dart';

class MarkerPage extends StatefulWidget {
  const MarkerPage({super.key});

  static const routeName = '/markerPage';

  @override
  State<MarkerPage> createState() => _MarkerPageState();
}

class _MarkerPageState extends State<MarkerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarkersCubit, MarkersState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetOneMarker) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("kembali"),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                  ),
                  iconSize: 40,
                ),
              ],
            ),
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: SizedBox(
                      width: deviceWidth,
                      height: deviceHeight * 0.3,
                      child: PageView.builder(
                        itemCount: state.marker.image.length,
                        itemBuilder: (context, index) {
                          return FadeInImage(
                            placeholder:
                                const AssetImage("assets/gif/loading.gif"),
                            image: NetworkImage(state.marker.image[index]),
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
