import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderer/presentations/pages/auth/login_page.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  static const routeName = './EmailVerificationPage';

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer = Timer.periodic(
        const Duration(seconds: 3), (_) => checkEmailVerification());
    super.initState();
  }

  void checkEmailVerification() async {
    await FirebaseAuth.instance.currentUser?.reload();
    print(isEmailVerified);
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      Navigator.of(context).pushNamed(LoginPage.routeName);
    }

    timer?.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: deviceWidth * 0.4,
                height: deviceHeight * 0.15,
                padding: EdgeInsets.all(deviceWidth * 0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromRGBO(217, 217, 217, 1),
                ),
                child: Image.asset("assets/img/email.png"),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: deviceWidth * 0.05),
                child: Text(
                  "Check Your Email",
                  style: blackTextStyle.copyWith(
                    fontSize: deviceWidth * 0.06,
                    fontWeight: bold,
                  ),
                ),
              ),
              const Text(
                "We have sent an email confirmation, click link in that email to finish activated your account",
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.08),
                child: CircularProgressIndicator(
                  color: baseColor,
                ),
              ),
              const Text(
                  "Did not receive the email? Check your spam filter or"),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              GestureDetector(
                onTap: () {},
                child: const Text("Resend email"),
              ),
              SizedBox(
                height: deviceHeight * 0.2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
