import 'package:flutter/material.dart';

import '../../routes/router_delegate.dart';
import 'get_started_widget.dart';

class GettingStartedFirst extends StatelessWidget {
  const GettingStartedFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetStartedWidget(
        image: "first",
        title: "Welcome To Wanderer",
        subtitle: "Discover the Ease of Your Journey Here.",
        onTapCallback: () {
          (Router.of(context).routerDelegate as MyRouterDelegate).nextSecond();
        },
        number: '1',
      ),
    );
  }
}
