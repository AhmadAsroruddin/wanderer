import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderer/presentations/pages/admin_page/step1_page.dart';
import 'package:wanderer/presentations/shared/customButton.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class GetStartedWandererPage extends StatelessWidget {
  const GetStartedWandererPage({super.key});

  static const routeName = '/GetStartedWandererPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Back",
          style: blackTextStyle,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.05, vertical: deviceHeight * 0.05),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: deviceWidth,
              child: Text(
                "It's easy to get started\non Wanderer",
                textAlign: TextAlign.left,
                style: GoogleFonts.ibmPlexSans().copyWith(
                  color: Colors.black,
                  fontWeight: bold,
                  fontSize: deviceWidth * 0.07,
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Padding(
                  padding: EdgeInsets.only(bottom: deviceHeight * 0.015),
                  child: const Text("Tell us about your place"),
                ),
                subtitle: const Text(
                    "Share some basic info, such as where it is and how many guests can stay."),
                trailing: Image.asset("assets/admin/campsite.png"),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Padding(
                  padding: EdgeInsets.only(bottom: deviceHeight * 0.015),
                  child: const Text("Make it stand out"),
                ),
                subtitle: const Text(
                    "Add 5 or more photos plus a title and description-we”ll help you out."),
                trailing: Image.asset("assets/admin/direction.png"),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Padding(
                  padding: EdgeInsets.only(bottom: deviceHeight * 0.015),
                  child: const Text("Finish and Publish"),
                ),
                subtitle: const Text(
                    "Choose if you'd like to start with an experienced guest, set a starting price and publish your listing"),
                trailing: Image.asset("assets/admin/arrow.png"),
              ),
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Step1Page.routeName);
              },
              child: const CustomButton(name: "Get Started"),
            )
          ],
        ),
      ),
    );
  }
}
