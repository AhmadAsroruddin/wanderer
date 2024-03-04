import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/pages/auth/resetConfirmation.dart';
import 'package:wanderer/presentations/shared/alertDialog.dart';
import 'package:wanderer/presentations/shared/customButton.dart';
import 'package:wanderer/presentations/shared/theme.dart';
import 'package:wanderer/presentations/shared/utils.dart';

import '../../bloc/auth_bloc.dart';

class ResetPage extends StatelessWidget {
  ResetPage({super.key});

  static const routeName = "./resetPage";
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kembali",
          style: blackTextStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetSended) {
            Navigator.of(context).pushNamed(ResetConfirmation.routeName);
          } else if (state is AuthError) {
            DialogUtils.alertDialog(context, "Error", state.error);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: deviceHeight * 0.01,
                    ),
                    Text(
                      "Reset Password",
                      style: SafeGoogleFont('ibmPlexSans').copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Enter the email associated with your account\nand we'll send email with instructions to\nreset your password",
                      style: SafeGoogleFont('inter').copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    Text(
                      "Email Address",
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        height: 1.2125,
                        color: const Color.fromRGBO(100, 100, 100, 1),
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.01,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.06,
                      width: double.infinity,
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: "Enter Your Email Address",
                          hintStyle: SafeGoogleFont(
                            'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.2125,
                            color: const Color(0xff636363),
                          ),
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.03,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await context
                            .read<AuthCubit>()
                            .resetPassword(email.text);
                      },
                      child: const CustomButton(
                        name: "Send Instructions",
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.12,
                    ),
                    Image.asset("assets/img/reset.png")
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
