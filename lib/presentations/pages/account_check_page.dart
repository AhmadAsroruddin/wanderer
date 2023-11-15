import 'package:flutter/material.dart';
import 'package:wanderer/presentations/pages/auth/login_page.dart';
import 'package:wanderer/presentations/pages/auth/register_page.dart';

import '../shared/theme.dart';

class AccountCheckPage extends StatelessWidget {
  const AccountCheckPage({super.key});
  static const routeName = '/accountCheckPage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  width: deviceWidth * 0.9,
                  height: deviceHeight * 0.3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/getStarted/check.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(LoginPage.routeName);
                    },
                    child: Container(
                      width: deviceWidth * 0.3,
                      height: deviceHeight * 0.05,
                      decoration: BoxDecoration(color: baseColor),
                      child: const Center(child: Text("Login")),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(RegisterPage.routeName);
                    },
                    child: Container(
                      width: deviceWidth * 0.3,
                      height: deviceHeight * 0.05,
                      decoration: BoxDecoration(color: baseColor),
                      child: const Center(child: Text("SignUp")),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
