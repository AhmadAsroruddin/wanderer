import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/presentations/bloc/admin_bloc.dart';
import 'package:wanderer/presentations/bloc/type_bloc.dart';

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
  @override
  void initState() {
    context.read<TypeCubitData>().getType(widget.widget.markers.userId);
    context.read<AdminCubit>().getAdminData(widget.widget.markers.id);
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
              if (state is TypeDataSuccess) {
                return Column(
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.27,
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
                                Container(
                                  //gambar
                                  width: deviceWidth * 0.7,
                                  height: deviceHeight * 0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 0.03),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        state.tipe[index].images[0],
                                      ),
                                      fit: BoxFit.fill,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          width: deviceWidth * 0.3,
                                          child: Text(
                                            "Rp.${state.tipe[index].price.toString()}",
                                            style: blackTextStyle.copyWith(
                                              fontSize: deviceWidth * 0.04,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: deviceWidth * 0.25,
                                          height: deviceHeight * 0.3,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                15,
                                              ),
                                              color: baseColor),
                                          child: const Center(
                                            child: Text("Pesan"),
                                          ),
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
          widgetChild: BlocBuilder<AdminCubit, Admin>(
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
                    SizedBox(
                      height: deviceHeight * 0.2,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 4 / 3,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                        ),
                        padding: EdgeInsets.zero,
                        itemCount: state.facilities.length,
                        itemBuilder: (context, indexFac) {
                          return Center(
                            child: SizedBox(
                              width: deviceWidth * 0.3,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    state.facilities[indexFac],
                                  ),
                                  state.category == "Campervan"
                                      ? SizedBox(
                                          width: deviceWidth * 0.2,
                                          child: Image.asset(
                                            "assets/admin/campsite/${state.facilities[indexFac].toString().toLowerCase()}.png",
                                            scale: 1.5,
                                          ),
                                        )
                                      : Image.asset(
                                          "assets/admin/campervan/${state.facilities[indexFac].toString().toLowerCase()}.png",
                                          scale: 1.5,
                                        )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
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
