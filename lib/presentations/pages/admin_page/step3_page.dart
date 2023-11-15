import 'package:flutter/material.dart';

import 'package:wanderer/presentations/shared/customButton.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import '../tab_screen.dart';

class Step3Page extends StatelessWidget {
  const Step3Page({super.key});
  static const routeName = '/step3Page';

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
                      image: AssetImage("assets/admin/step3.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.05,
              ),
              const Text("Step 3"),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              Text(
                "Finish up and publish",
                style: blackTextStyle.copyWith(
                  fontSize: deviceWidth * 0.05,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              const Text(
                "Finally, you’ll choose if you’d like to start with an experienced guest, then you’ll set your nightly price. Answer a few quick questions and publish when you’re ready.",
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(TabScreen.routeName);
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
