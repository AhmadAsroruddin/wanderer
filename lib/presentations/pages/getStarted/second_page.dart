import 'package:flutter/material.dart';
import 'package:wanderer/presentations/pages/getStarted/get_started_widget.dart';
import 'package:wanderer/presentations/routes/router_delegate.dart';

class GettingStartedSecond extends StatelessWidget {
  const GettingStartedSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetStartedWidget(
      number: "2",
      image: "second",
      title: "Explore with Wanderer",
      subtitle:
          "Explore Limitless Adventures with Us! Wanderer, Your Ultimate Travel Companion.",
      onTapCallback: () {
        (Router.of(context).routerDelegate as MyRouterDelegate).nextThird();
      },
    ));
  }
}
