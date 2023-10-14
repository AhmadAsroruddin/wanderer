import 'package:flutter/material.dart';

import 'package:wanderer/presentations/pages/admin_page/facilities_page.dart';
import 'package:wanderer/presentations/shared/customButton.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class Step2Page extends StatelessWidget {
  const Step2Page({super.key});
  static const routeName = '/step2Page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kembali",
          style: blackTextStyle,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: deviceWidth * 0.05, vertical: deviceHeight * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  width: deviceWidth * 0.8,
                  height: deviceHeight * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage("assets/admin/step2.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.05,
              ),
              const Text("Step 2"),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              Text(
                "Make your place stand out",
                style: blackTextStyle.copyWith(
                  fontSize: deviceWidth * 0.05,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              const Text(
                "In this step, you will add some of the amenities your place offers, plus 3 or more photos. ",
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(FacilitiesPage.routeName);
                },
                child: const CustomButton(name: "Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
