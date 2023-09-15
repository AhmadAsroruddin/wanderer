import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderer/presentations/pages/auth/login_page.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class ResetConfirmation extends StatelessWidget {
  const ResetConfirmation({super.key});

  static const routeName = "/resetConfirmation";

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: deviceWidth * 0.5,
                height: deviceHeight * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(217, 217, 217, 1.0),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/img/emailicon.png",
                    width: deviceWidth * 0.35,
                    height: deviceHeight * 0.1,
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              Text(
                "Check your Email",
                style: GoogleFonts.ibmPlexSans().copyWith(
                  fontWeight: bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              const Text(
                "We have sent a password recover instructions\nto your email.",
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginPage.routeName);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromRGBO(255, 215, 0, 1),
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                ),
                child: const Text("Back to Login"),
              ),
              SizedBox(
                height: deviceHeight * 0.2,
              ),
              const Text("Did not receive the email? Check your spam filter."),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("or "),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "try another email address",
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
