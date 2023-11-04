import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/router_bloc.dart';
import 'package:wanderer/presentations/pages/auth/login_page.dart';
import 'package:wanderer/presentations/routes/router_delegate.dart';

class GettingStartedThird extends StatelessWidget {
  const GettingStartedThird({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("ini halaman ketiga"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      (Router.of(context).routerDelegate as MyRouterDelegate)
                          .firstTimeDone();
                      await context.read<RouterCubit>().firstTimeFalse();
                      Navigator.of(context)
                          .pushReplacementNamed(LoginPage.routeName);
                    },
                    child: const Text("Login"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      (Router.of(context).routerDelegate as MyRouterDelegate)
                          .firstTimeDone();
                    },
                    child: const Text("Skip"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
