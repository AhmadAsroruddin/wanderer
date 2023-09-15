import 'package:flutter/material.dart';
import '../shared/utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // splashscreenpbb (53:20)
        padding: EdgeInsets.fromLTRB(80 * fem, 7 * fem, 80 * fem, 32 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff000000)),
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(20 * fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogroupkzwrKHT (EHhAG5Ek5ZqEG4uyBqkzWR)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 4 * fem, 229 * fem),
              width: 24 * fem,
              height: 24 * fem,
              child: Image.asset(
                'assets/img/auto-group-kzwr.png',
                width: 24 * fem,
                height: 24 * fem,
              ),
            ),
            Container(
              // image142pzu (423:11)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 210 * fem),
              width: 200 * fem,
              height: 200 * fem,
              child: Image.asset(
                'assets/img/image-142.png',
                fit: BoxFit.cover,
              ),
            ),
            Text(
              // ver140LiM (323:439)
              'ver 1.40',
              style: SafeGoogleFont(
                'Roboto',
                fontSize: 15 * ffem,
                fontWeight: FontWeight.w400,
                height: 0.5 * ffem / fem,
                color: const Color(0x7f000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
