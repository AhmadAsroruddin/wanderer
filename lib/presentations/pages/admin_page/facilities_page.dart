import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderer/presentations/bloc/admin_bloc.dart';
import 'package:wanderer/presentations/pages/admin_page/addPhoto_page.dart';
import 'package:wanderer/presentations/shared/customButton.dart';

import '../../shared/theme.dart';

class FacilitiesPage extends StatefulWidget {
  const FacilitiesPage({super.key});

  static const routeName = '/facilitiesPage';

  @override
  State<FacilitiesPage> createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends State<FacilitiesPage> {
  final campsite = [
    "Parkir",
    "Kayu Bakar",
    "Listrik",
    "Musholla",
    "Toilet",
    "Tenda",
    "Wifi",
    "Warung",
  ];

  final campervan = [
    "audio",
    "kompor",
    "lampu",
    "matras",
    "mobil",
    "nesting",
    "roof tent"
  ];

  List<bool>? onClickList;
  String? category;
  @override
  void initState() {
    super.initState();
    onClickList = List.generate(campsite.length, (index) => false);
    category = context.read<AdminCubit>().getCategory();
  }

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
                "Tell guests what your place has to offer",
                style: GoogleFonts.roboto().copyWith(
                  fontSize: deviceWidth * 0.05,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.015,
              ),
              const Text(
                "You can add more amenities after you publish\nyour listing.",
              ),
              SizedBox(
                height: deviceHeight * 0.015,
              ),
              Expanded(
                child: Center(
                  child: GridView.builder(
                    itemCount: category == "Paid_Campsite"
                        ? campsite.length
                        : campervan.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<AdminCubit>()
                              .setFacilities(campsite[index]);
                          setState(() {
                            onClickList![index] = !onClickList![index];
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.01,
                            vertical: deviceHeight * 0.005,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 1,
                                color: onClickList![index] == true
                                    ? redColor
                                    : greyColor),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              category == "Paid_Campsite"
                                  ? Image.asset(
                                      "assets/admin/campsite/${campsite[index].toLowerCase()}.png")
                                  : Image.asset(
                                      "assets/admin/campervan/${campervan[index].toLowerCase()}.png"),
                              SizedBox(
                                height: deviceHeight * 0.01,
                              ),
                              Text(
                                category == "Paid_Campsite"
                                    ? campsite[index]
                                    : campervan[index],
                                style: GoogleFonts.roboto().copyWith(
                                  fontSize: deviceWidth * 0.04,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AddPhotoPage.routeName);
                  },
                  child: const CustomButton(name: "Next")),
            ],
          ),
        ),
      ),
    );
  }
}
