import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/data/models/marker_model.dart';
import 'package:wanderer/domain/entities/user.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/pages/edit_marker.dart';
import 'package:wanderer/presentations/shared/CardAccount.dart';
import 'package:wanderer/presentations/shared/alertDialog.dart';

import '../shared/theme.dart';

class YourMarkerPage extends StatefulWidget {
  const YourMarkerPage({super.key});
  static const routeName = "/YourMarkerPage";

  @override
  State<YourMarkerPage> createState() => _YourMarkerPageState();
}

class _YourMarkerPageState extends State<YourMarkerPage> {
  String data = "";
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final data = ModalRoute.of(context)!.settings.arguments;

      if (data != null && data is Users) {
        await context.read<MarkersCubit>().getMarkerUser(data.markers);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Marker You've added"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SafeArea(
          child: BlocBuilder<MarkersCubit, MarkersState>(
            builder: (context, state) {
              if (state is GetUserMarkerSuccess) {
                return ListView.builder(
                  itemCount: state.markers.length,
                  itemBuilder: (context, index) {
                    MarkerModel marker = state.markers[index];
                    if (marker.jenis == "Paid_Campsite" ||
                        marker.jenis == "Campervan") {
                      return Container();
                    } else {
                      return Padding(
                        padding: EdgeInsets.all(deviceWidth * 0.02),
                        child: CardAccount(
                          deviceWidth: deviceWidth,
                          deviceHeight: deviceHeight,
                          title: marker.name,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: deviceWidth * 0.2,
                                height: deviceHeight * 0.08,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/markers/${marker.jenis.toLowerCase()}.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      EditMarkerPage.routeName,
                                      arguments: marker);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow,
                                ),
                                child: Text(
                                  "Edit",
                                  style: blackTextStyle.copyWith(
                                      fontWeight: semiBold),
                                ),
                              ),
                              SizedBox(
                                width: deviceWidth * 0.01,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await context
                                      .read<MarkersCubit>()
                                      .delete(marker.id);
                                  DialogUtils.alertDialog(
                                      context, "Success", "Marker Deleted");
                                  setState(() {
                                    data = "success";
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: Text(
                                  "Delete",
                                  style: whiteTextStyle.copyWith(
                                      fontWeight: semiBold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              } else if (state is MarkersLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: Text("No Data Found, Add marker first"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
