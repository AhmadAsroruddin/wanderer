import 'package:flutter/material.dart';
import 'package:wanderer/presentations/routes/router_delegate.dart';

class GettingStartedFirst extends StatelessWidget {
  const GettingStartedFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Text("ini halaman pertama"),
            ),
            ElevatedButton(
              onPressed: () {
                (Router.of(context).routerDelegate as MyRouterDelegate)
                    .nextSecond();
              },
              child: const Text("Next"),
            )
          ],
        ),
      ),
    );
  }
}
