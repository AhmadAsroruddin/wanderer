import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wanderer/presentations/bloc/favorite_bloc.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/pages/account_check_page.dart';
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
  bool isFavorite = false;
  String markerId = "";
  String previousMarkerId = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarkersCubit, MarkersState>(
      builder: (context, state) {
        if (state is GetOneMarker) {
          FirebaseAuth firebaseAuth = FirebaseAuth.instance;
          previousMarkerId = state.marker.id;
          String userId = "";

          if (firebaseAuth.currentUser == null) {
            return const AccountCheckPage();
          } else {
            userId = firebaseAuth.currentUser!.uid.toString();
            context
                .read<FavoriteCubit>()
                .favoriteCheck(state.marker.id, userId)
                .then((value) {
              setState(() {
                isFavorite = value;
              });
            });
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text("kembali"),
                actions: [
                  IconButton(
                    onPressed: () async {
                      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                      String userId = firebaseAuth.currentUser!.uid.toString();

                      if (isFavorite == false) {
                        await context
                            .read<FavoriteCubit>()
                            .addMarkerToFavorite(userId, state.marker.id);
                      } else {
                        await context
                            .read<FavoriteCubit>()
                            .remove(state.marker.id, userId);
                      }

                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    icon: const Icon(
                      Icons.favorite,
                    ),
                    iconSize: 40,
                    color: isFavorite == true ? Colors.red : Colors.black,
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
                                      state.marker.name,
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
                              child: GestureDetector(
                                onTap: () async {
                                  final url = Uri.parse(
                                      'https://www.google.com/maps/search/?api=1&query=${state.marker.latitude},${state.marker.longitude}');

                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    throw 'can\'t launch Google Maps';
                                  }
                                },
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
                                    child:
                                        Image.asset("assets/img/direction.png"),
                                  ),
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
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
