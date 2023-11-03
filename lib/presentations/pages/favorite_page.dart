import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/favorite_bloc.dart';
import 'package:wanderer/presentations/pages/campervan_page/campervan_list.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
  static const routeName = "/favoritePage";

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
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const CampervanList();
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
