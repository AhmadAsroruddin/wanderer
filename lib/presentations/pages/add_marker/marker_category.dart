import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderer/domain/entities/user.dart';
import 'package:wanderer/presentations/bloc/admin_bloc.dart';
import 'package:wanderer/presentations/bloc/user_bloc.dart';
import 'package:wanderer/presentations/pages/add_marker/tambah_marker.dart';
import 'package:wanderer/presentations/pages/admin_page/getStarted_page.dart';
import 'package:wanderer/presentations/routes/router_delegate.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import '../../shared/alertDialog.dart';

class MarkerCategoryPage extends StatelessWidget {
  MarkerCategoryPage({super.key});
  static const routeName = '/markerCategoryPage';

  final List<Map<String, String>> data = [
    {'image': 'restaurant', 'name': 'Restaurant'},
    {'image': 'spbu', 'name': 'SPBU'},
    {'image': 'campervan', 'name': 'Campervan'},
    {'image': 'campsite', 'name': 'Paid_Campsite'},
    {'image': 'campsite', 'name': 'Free_Campsite'},
    {'image': 'mountain', 'name': 'Mountain'},
    {'image': 'beach', 'name': 'Beach'},
    {'image': 'lake', 'name': 'Lake'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Category",
          style: blackTextStyle,
        ),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              (Router.of(context).routerDelegate as MyRouterDelegate)
                  .addCategory(data[index]['name']!);
              if (data[index]['name'] == "Campervan" ||
                  data[index]['name'] == "Paid_Campsite") {
                User? currUser = FirebaseAuth.instance.currentUser;
                Users users = await context
                    .read<UserCubit>()
                    .getUserReturn(currUser!.uid);
                if (users.role == "") {
                  Navigator.of(context)
                      .pushNamed(GetStartedWandererPage.routeName);
                  context.read<AdminCubit>().setCategory(data[index]['name']!);
                } else {
                  DialogUtils.alertDialog(
                      context, "Error !!!", "You Already be Admin");
                }
              } else {
                Navigator.of(context).pushNamed(AddMarkerPage.routeName,
                    arguments: data[index]['name']!);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              width: deviceHeight * 1,
              height: deviceHeight * 0.1,
              child: Row(
                children: <Widget>[
                  Image.asset(
                      "assets/img/category/${data[index]['image']}.png"),
                  SizedBox(
                    width: deviceWidth * 0.05,
                  ),
                  Text(
                    data[index]['name']!,
                    style: GoogleFonts.roboto().copyWith(fontSize: 18),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
