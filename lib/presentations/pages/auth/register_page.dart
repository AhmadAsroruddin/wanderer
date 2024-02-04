import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wanderer/presentations/bloc/auth_bloc.dart';
import 'package:wanderer/presentations/shared/alertDialog.dart';
import 'package:wanderer/presentations/shared/google_continue.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import 'email_verification.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const routeName = "/registerPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    TextEditingController username = TextEditingController();
    TextEditingController emailAddress = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();

    @override
    void dispose() {
      // Hapus controller ketika widget di-dispose
      username.dispose();
      emailAddress.dispose();
      password.dispose();
      phoneNumber.dispose();
      super.dispose();
    }

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthData) {
          DialogUtils.alertDialog(
              context, "Success", "Account Created Successfully");
          FirebaseAuth.instance.currentUser?.sendEmailVerification();
          Navigator.of(context).pushNamed(EmailVerificationPage.routeName);
        } else if (state is AuthError) {
          DialogUtils.alertDialog(context, "Error", state.error);
        }
      },
      builder: (context, state) {
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "HI",
                            style: GoogleFonts.ibmPlexSans().copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Create a new account",
                            style: TextStyle(
                              color: Color.fromRGBO(62, 63, 64, 1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.15,
                        width: deviceWidth * 0.3,
                        child: Image.asset(
                          "assets/img/register.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextFieldRegister(
                        deviceHeight: deviceHeight,
                        hintText: "Username",
                        controller: username,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldRegister(
                        deviceHeight: deviceHeight,
                        hintText: "Email Address",
                        controller: emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldRegister(
                        deviceHeight: deviceHeight,
                        hintText: "Phone Number",
                        controller: phoneNumber,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldRegister(
                        deviceHeight: deviceHeight,
                        hintText: "Password",
                        obscure: true,
                        controller: password,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await context.read<AuthCubit>().createAccount(
                          username.text,
                          emailAddress.text,
                          password.text,
                          phoneNumber.text);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      foregroundColor: Colors.black,
                      backgroundColor: const Color.fromRGBO(255, 215, 0, 1),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 10),
                    ),
                    child: state is AuthLoading
                        ? const CircularProgressIndicator()
                        : const Text("create"),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an account?",
                        style: GoogleFonts.inter().copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.2125,
                          color: const Color(0xff636363),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.inter().copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.2125,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  SizedBox(
                    width: deviceWidth * 0.5,
                    child: GoogleContinue(
                      screenSize: MediaQuery.of(context).size,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TextFieldRegister extends StatelessWidget {
  const TextFieldRegister(
      {super.key,
      required this.deviceHeight,
      this.obscure = false,
      required this.hintText,
      required this.controller});

  final double deviceHeight;
  final bool obscure;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceHeight * 0.06,
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter().copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.2125,
            color: const Color(0xff636363),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
