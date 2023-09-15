import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/auth_bloc.dart';
import 'package:wanderer/presentations/pages/auth/register_page.dart';
import 'package:wanderer/presentations/pages/auth/reset_page.dart';
import 'package:wanderer/presentations/pages/tab_screen.dart';
import 'package:wanderer/presentations/shared/alertDialog.dart';

import '../../shared/customTextField.dart';
import '../../shared/google_continue.dart';
import '../../shared/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const routeName = '/loginPage';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLogin) {
          Navigator.of(context).pushNamed(TabScreen.routeName);
        } else if (state is AuthError) {
          DialogUtils.alertDialog(context, "Error", state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.03,
                  horizontal: screenSize.width * 0.15),
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    height: screenSize.height * 0.35,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/login_image.png'),
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: email,
                    screenSize: screenSize,
                    hintText: "Enter your email address",
                    icon: const Icon(Icons.email),
                    label: "Email Address",
                  ),
                  SizedBox(
                    height: screenSize.height * 0.012,
                  ),
                  CustomTextField(
                    controller: password,
                    screenSize: screenSize,
                    hintText: "Enter your password",
                    icon: const Icon(Icons.lock),
                    label: "Password",
                    obscureText: true,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.006,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(ResetPage.routeName);
                      },
                      child: const Text(
                        "Forget Password",
                        style: TextStyle(
                          color: Color.fromRGBO(100, 100, 100, 1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<AuthCubit>()
                          .login(email.text, password.text);
                    },
                    child: Container(
                      width: double.infinity,
                      height: screenSize.height * 0.05,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 215, 0, 1),
                      ),
                      child: Center(
                        child: state is AuthLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                "Log in",
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2125,
                                  color: const Color(0xff000000),
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have account?",
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.2125,
                          color: const Color(0xff636363),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RegisterPage.routeName);
                        },
                        child: Text(
                          "Sign Up",
                          style: SafeGoogleFont(
                            'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.2125,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  GoogleContinue(screenSize: screenSize)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
