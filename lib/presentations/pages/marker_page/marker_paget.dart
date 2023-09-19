import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/pages/marker_page/marker_tab_page.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class MarkerPage extends StatefulWidget {
  const MarkerPage({super.key});

  static const routeName = '/markerPage';

  @override
  State<MarkerPage> createState() => _MarkerPageState();
}

class _MarkerPageState extends State<MarkerPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarkersCubit, MarkersState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetOneMarker) {
          return Scaffold(
            backgroundColor: Colors.white,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.3,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: deviceWidth,
                            height: deviceHeight * 0.27,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  left: 0,
                                  child: SizedBox(
                                    width: deviceWidth,
                                    height: deviceHeight * 0.27,
                                    child: PageView.builder(
                                      itemCount: state.marker.image.length,
                                      itemBuilder: (context, index) {
                                        return FadeInImage(
                                          placeholder: const AssetImage(
                                              "assets/gif/loading.gif"),
                                          image: NetworkImage(
                                              state.marker.image[index]),
                                          fit: BoxFit.fill,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  left: 0,
                                  bottom: 0,
                                  child: Text(
                                    "Tebing Watu Mabur",
                                    style: GoogleFonts.imprima().copyWith(
                                      fontSize: 30,
                                      color: whiteColor,
                                      fontWeight: bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.5),
                                shape: BoxShape.circle,
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black.withOpacity(
                                //         0.5), // Warna bayangan dan opasitas
                                //     spreadRadius: 2.0, // Menyebar bayangan
                                //     blurRadius: 5.0, // Ketajaman bayangan
                                //     offset:
                                //         Offset(0, 2), // Posisi bayangan (x, y)
                                //   ),
                                // ],
                              ),
                              child: CircleAvatar(
                                backgroundColor: whiteColor,
                                radius: 30,
                                child: Image.asset("assets/img/direction.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    MarkerTab(
                      markers: state.marker,
                    )
                  ],
                ),
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
