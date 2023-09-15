import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/auth_bloc.dart';

class GoogleContinue extends StatelessWidget {
  const GoogleContinue({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AuthCubit>().signInWithGoogle();
      },
      child: Container(
        width: double.infinity,
        height: screenSize.height * 0.05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: screenSize.width * 0.1,
                height: screenSize.height * 0.03,
                child: Image.asset(
                  "assets/img/google_icon.png",
                ),
              ),
              const Text("Continue with Google"),
            ],
          ),
        ),
      ),
    );
  }
}
