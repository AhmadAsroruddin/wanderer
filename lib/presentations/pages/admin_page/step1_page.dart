import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/data/models/admin_model.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/presentations/bloc/admin_bloc.dart';
import 'package:wanderer/presentations/pages/admin_page/addLocation.dart';
import 'package:wanderer/presentations/shared/customButton.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class Step1Page extends StatelessWidget {
  const Step1Page({super.key});
  static const routeName = '/step1Page';

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
                      image: AssetImage("assets/admin/step1.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.05,
              ),
              const Text("Step 1"),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              Text(
                "Tell us about your place",
                style: blackTextStyle.copyWith(
                  fontSize: deviceWidth * 0.05,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              const Text(
                "In this step, we\"ll ask you which type of property you have. Then let us know the location and how many guests can stay.",
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AddLocation.routeName);
                },
                child: const CustomButton(name: "Next"),
              ),
              BlocConsumer<AdminCubit, AdminModel>(builder: (context, state) {
                return Container();
              }, listener: (context, state) {
                print(state);
              })
            ],
          ),
        ),
      ),
    );
  }
}
