import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/router_bloc.dart';
import 'package:wanderer/presentations/pages/auth/login_page.dart';
import 'package:wanderer/presentations/pages/getStarted/get_started_widget.dart';
import 'package:wanderer/presentations/routes/router_delegate.dart';

class GettingStartedThird extends StatelessWidget {
  const GettingStartedThird({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetStartedWidget(
        image: "third",
        number: "3",
        title: "Adventure with Wanderer",
        subtitle:
            "Begin Your Adventure with Greater Ease. Let's Find and Book Your Dream Experience with Wanderer.",
        onTapCallback: () async {
          (Router.of(context).routerDelegate as MyRouterDelegate)
              .firstTimeDone();
          await context.read<RouterCubit>().firstTimeFalse();
          Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
        },
      ),
    );
  }
}
