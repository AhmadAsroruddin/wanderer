import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/entities/tipe.dart';
import 'package:wanderer/domain/entities/user.dart';
import 'package:wanderer/presentations/bloc/admin_bloc.dart';
import 'package:wanderer/presentations/bloc/type_bloc.dart';
import 'package:wanderer/presentations/bloc/user_bloc.dart';
import 'package:wanderer/presentations/pages/order_page/order_page.dart';
import 'package:wanderer/presentations/shared/alertDialog.dart';

import '../../shared/theme.dart';
import 'marker_detail_page.dart';

class PaidMarkerPage extends StatefulWidget {
  const PaidMarkerPage(
      {super.key, required this.widget, required this.adminId});

  final DetailsPage widget;
  final String adminId;

  @override
  State<PaidMarkerPage> createState() => _PaidMarkerPageState();
}

class _PaidMarkerPageState extends State<PaidMarkerPage> {
  int amount = 1;
  String? adminName;

  @override
  void initState() {
    context.read<TypeCubitData>().getType(widget.widget.markers.userId);
    context.read<AdminCubit>().getAdminData(widget.adminId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DetailContainer(
          widget: widget.widget,
          widgetChild: BlocBuilder<TypeCubitData, TypeDataState>(
            builder: (context, state) {
              if (state is TypeDataSuccessState) {
                return Column(
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.37,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.tipe.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: deviceWidth * 0.01),
                            height: deviceHeight * 0.6,
                            width: deviceWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 0.25),
                            ),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PhotoViewPage(
                                            state.tipe[index].images, index),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    //gambar
                                    width: deviceWidth * 0.7,
                                    height: deviceHeight * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(width: 0.03),
                                    ),
                                    child: Hero(
                                      tag: 'imageHero',
                                      child: Image.network(
                                        state.tipe[index].images[0],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: deviceWidth * 0.6,
                                    padding: EdgeInsets.only(
                                      left: deviceWidth * 0.03,
                                    ),
                                    child: Text(
                                      state.tipe[index].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: blackTextStyle.copyWith(
                                        fontSize: deviceWidth * 0.05,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    DialogUtils.alertDialog(
                                        context,
                                        "Description",
                                        state.tipe[index].description);
                                  },
                                  child: Container(
                                    width: deviceWidth * 0.65,
                                    child: Text(
                                      state.tipe[index].description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: deviceHeight * 0.02,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: deviceWidth * 0.03,
                                      bottom: deviceHeight * 0.01,
                                      right: deviceWidth * 0.03,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          child: Text(
                                            "Rp.${state.tipe[index].price.toString()}",
                                            style: blackTextStyle.copyWith(
                                              fontSize: deviceWidth * 0.04,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              child: Row(
                                                children: <Widget>[
                                                  IconButton(
                                                    onPressed: () {
                                                      if (amount > 1) {
                                                        setState(() {
                                                          amount = amount - 1;
                                                        });
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.remove,
                                                    ),
                                                  ),
                                                  Text(
                                                    amount.toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          deviceWidth * 0.04,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        amount = amount + 1;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.add,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                User? currUserData =
                                                    FirebaseAuth
                                                        .instance.currentUser;
                                                Users user = await context
                                                    .read<UserCubit>()
                                                    .getUserReturn(
                                                        currUserData!.uid);
                                                if (user.role ==
                                                    state.tipe[index].adminId) {
                                                  DialogUtils.alertDialog(
                                                      context,
                                                      "ERROR!!!",
                                                      "You Can't Order on Your own ");
                                                } else {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                    OrderPage.routeName,
                                                    arguments: [
                                                      Tipe(
                                                        id: state
                                                            .tipe[index].id,
                                                        name: state
                                                            .tipe[index].name,
                                                        price: state
                                                            .tipe[index].price,
                                                        facility: state
                                                            .tipe[index]
                                                            .facility,
                                                        images: state
                                                            .tipe[index].images,
                                                        capacity: state
                                                            .tipe[index]
                                                            .capacity,
                                                        description: state
                                                            .tipe[index]
                                                            .description,
                                                        adminId: state
                                                            .tipe[index]
                                                            .adminId,
                                                      ),
                                                      amount,
                                                      adminName,
                                                    ],
                                                  );
                                                }
                                              },
                                              child: Container(
                                                width: deviceWidth * 0.25,
                                                height: deviceHeight * 0.05,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    15,
                                                  ),
                                                  color: baseColor,
                                                ),
                                                child: const Center(
                                                  child: Text("Pesan"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        DetailContainer(
          widget: widget.widget,
          widgetChild: BlocConsumer<AdminCubit, Admin>(
            listener: (context, state) {
              setState(() {
                adminName = state.name;
              });
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceWidth * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Fasilitias",
                      style: blackTextStyle.copyWith(
                        fontSize: deviceWidth * 0.05,
                      ),
                    ),
                    Container(
                        height: deviceHeight * 0.1,
                        width: deviceWidth,
                        alignment: Alignment.center,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.facilities.length,
                          itemBuilder: (context, indexFac) {
                            return Container(
                              margin:
                                  EdgeInsets.only(right: deviceWidth * 0.05),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      state.facilities[indexFac],
                                    ),
                                  ),
                                  state.category == "Campervan"
                                      ? SizedBox(
                                          width: deviceWidth * 0.2,
                                          child: Image.asset(
                                            "assets/admin/campervan/${state.facilities[indexFac].toString().toLowerCase()}.png",
                                            scale: 1.5,
                                          ),
                                        )
                                      : SizedBox(
                                          width: deviceWidth * 0.2,
                                          child: Image.asset(
                                            "assets/admin/campsite/${state.facilities[indexFac].toString().toLowerCase()}.png",
                                            scale: 1.5,
                                          ),
                                        )
                                ],
                              ),
                            );
                          },
                        ))
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class PhotoViewPage extends StatelessWidget {
  final List<dynamic> imageUrls;
  final int initialIndex;

  const PhotoViewPage(this.imageUrls, this.initialIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoViewGallery.builder(
          itemCount: imageUrls.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(imageUrls[index]),
              heroAttributes: PhotoViewHeroAttributes(tag: 'imageHero$index'),
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          pageController: PageController(initialPage: initialIndex),
        ),
      ),
    );
  }
}
