import 'package:flutter/material.dart';
import 'package:wanderer/presentations/routes/router_delegate.dart';

class GettingStartedSecond extends StatelessWidget {
  const GettingStartedSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Text("ini halaman kedua"),
            ),
            ElevatedButton(
              onPressed: () {
                (Router.of(context).routerDelegate as MyRouterDelegate)
                    .nextThird();
              },
              child: const Text("next"),
            ),
          ],
        ),
      ),
    );
  }
}
