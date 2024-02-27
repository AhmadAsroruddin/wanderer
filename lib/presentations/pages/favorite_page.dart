import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/marker.dart';
import 'package:wanderer/presentations/bloc/favorite_bloc.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/pages/campervan_page/campervan_list.dart';
import 'package:wanderer/presentations/pages/marker_page/marker_paget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});
  static const routeName = "/favoritePage";

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    context.read<FavoriteCubit>().getAllFav(userId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Favorites"),
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: BlocConsumer<FavoriteCubit, FavoriteState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AllFavorites) {
              return ListView.builder(
                itemCount: state.favorite.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<Markers>(
                    future: context
                        .read<MarkersCubit>()
                        .getMarkerForFavorite(state.favorite[index].markerId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Tampilkan widget loading atau indikator progres di sini jika diperlukan
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // Tangani kesalahan jika diperlukan
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        // Akses data Admin saat sudah tersedia
                        return GestureDetector(
                          onTap: () async {
                            Markers marker = await context
                                .read<MarkersCubit>()
                                .getMarkerForFavorite(
                                    state.favorite[index].markerId);

                            context
                                .read<MarkersCubit>()
                                .getMarker(true, marker);
                            Navigator.of(context)
                                .pushNamed(MarkerPage.routeName);
                            Navigator.of(context)
                                .pushNamed(MarkerPage.routeName);
                          },
                          child: CampervanList(
                            name: snapshot.data!.name,
                            image: snapshot.data!.image[0],
                            address: snapshot.data!.address,
                            markerId: snapshot.data!.id,
                            isNeedButtonLove: false,
                          ),
                        );
                      } else {
                        // Tampilkan sesuatu jika tidak ada data
                        return const Text('Tidak ada data');
                      }
                    },
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
