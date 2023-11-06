import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/entities/tipe.dart';
import 'package:wanderer/presentations/bloc/auth_bloc.dart';
import 'package:wanderer/presentations/bloc/type_bloc.dart';
import 'package:wanderer/presentations/pages/tab_screen.dart';
import 'package:wanderer/presentations/shared/customButton.dart';

import '../../../domain/entities/marker.dart';
import '../../bloc/admin_bloc.dart';
import '../../bloc/markers_bloc.dart';
import '../../shared/theme.dart';
import 'card_type_list.dart';

class AddTypePage extends StatefulWidget {
  const AddTypePage({super.key});

  static const routeName = '/AddTypePage';

  @override
  State<AddTypePage> createState() => _AddTypePageState();
}

class _AddTypePageState extends State<AddTypePage> {
  bool ready = true;
  int i = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Back",
          style: blackTextStyle,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Location Details",
                style: GoogleFonts.roboto().copyWith(
                  fontSize: deviceWidth * 0.05,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Text(
                "Add some types and provide detailed information.",
                style: GoogleFonts.roboto().copyWith(
                  fontSize: deviceWidth * 0.035,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Expanded(
                child: Center(
                  child: ListView.builder(
                    itemCount: i,
                    itemBuilder: (context, index) {
                      return const ListTypeCard();
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      i++;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors
                        .transparent), // Ganti warna latar belakang sesuai yang Anda inginkan
                  ),
                  child: const Text("Add More"),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  addToFirestore();
                  Future.delayed(
                    const Duration(seconds: 5),
                    () {
                      Navigator.of(context).pushNamed(TabScreen.routeName);
                    },
                  );
                },
                child: const CustomButton(name: "Next"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addToFirestore() async {
    Admin admin = context.read<AdminCubit>().getAllAdmin();
    String userId = await context.read<AuthCubit>().getCurrentUser();
    Markers marker = Markers(
        name: admin.name,
        description: admin.description,
        image: admin.image,
        jenis: admin.category,
        latitude: admin.latitude,
        longitude: admin.longitude,
        userId: userId,
        contact: admin.noTelp,
        socialMedia: admin.instagram,
        address: admin.address,
        harga: "");
    final String markerid =
        await context.read<MarkersCubit>().addMarkerAdmin(marker, admin.image);

    await context.read<AdminCubit>().setMarkerId(markerid);

    String adminId =
        await context.read<AdminCubit>().addToAdmin(admin, markerid);
    await context.read<MarkersCubit>().update(adminId, markerid);

    List<Tipe> types = context.read<TypeCubit>().getTipe();

    await context.read<TypeCubit>().addType(types, adminId);

    context.read<AdminCubit>().updateUserRole(userId, adminId);
  }
}
