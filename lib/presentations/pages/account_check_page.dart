import 'package:flutter/material.dart';
import 'package:wanderer/presentations/pages/auth/login_page.dart';
import 'package:wanderer/presentations/pages/auth/register_page.dart';

class AccountCheckPage extends StatelessWidget {
  const AccountCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginPage.routeName);
                },
                child: const Text("Login"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterPage.routeName);
                },
                child: const Text("SignUp"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
