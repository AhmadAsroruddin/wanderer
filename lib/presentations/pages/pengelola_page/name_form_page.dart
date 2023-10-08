import 'package:flutter/material.dart';

class NameFormPage extends StatelessWidget {
  const NameFormPage({super.key});
  static const routeName = "/NameFormPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Masukan nama"),
                onChanged: (value) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Back")),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Next"),
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
