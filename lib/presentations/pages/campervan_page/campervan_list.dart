import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderer/presentations/bloc/auth_bloc.dart';

import '../../bloc/favorite_bloc.dart';
import '../../shared/theme.dart';

class CampervanList extends StatefulWidget {
  const CampervanList({
    required this.image,
    required this.name,
    required this.address,
    required this.markerId,
    this.isNeedButtonLove = true,
    super.key,
  });

  final String image;
  final String markerId;
  final String name;
  final String address;
  final bool isNeedButtonLove;

  @override
  State<CampervanList> createState() => _CampervanListState();
}

class _CampervanListState extends State<CampervanList> {
  bool? isFavorite;

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        String userId = await context.read<AuthCubit>().getCurrentUser();
        context
            .read<FavoriteCubit>()
            .favoriteCheck(widget.markerId, userId)
            .then((value) {
          setState(() {
            isFavorite = value;
          });
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth,
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(width: 0.2),
        ),
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
          width: deviceWidth * 0.98,
          child: Row(
            children: <Widget>[
              Container(
                width: deviceWidth * 0.3,
                height: deviceHeight * (0.1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: deviceWidth * 0.05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.name,
                    style: GoogleFonts.inter().copyWith(
                      fontSize: deviceWidth * 0.045,
                      fontWeight: bold,
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.01,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/img/marker.png",
                        scale: 2,
                      ),
                      SizedBox(
                        width: deviceWidth * 0.01,
                      ),
                      SizedBox(
                        width: widget.isNeedButtonLove
                            ? deviceWidth * 0.4
                            : deviceWidth * 0.5,
                        child: Text(
                          widget.address,
                          style: const TextStyle(fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: deviceWidth * 0.03,
              ),
              widget.isNeedButtonLove == true
                  ? IconButton(
                      onPressed: () async {
                        String userId =
                            await context.read<AuthCubit>().getCurrentUser();
                        if (isFavorite == false) {
                          await context
                              .read<FavoriteCubit>()
                              .addMarkerToFavorite(userId, widget.markerId);
                        } else {
                          await context
                              .read<FavoriteCubit>()
                              .remove(widget.markerId, userId);
                        }

                        setState(() {
                          isFavorite = !isFavorite!;
                        });
                      },
                      icon: isFavorite == true
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_outline,
                            ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
