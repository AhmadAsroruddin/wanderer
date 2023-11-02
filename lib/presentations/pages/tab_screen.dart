import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderer/presentations/pages/account_page.dart';
import 'package:wanderer/presentations/pages/campervan_page/campervan_page.dart';
import 'package:wanderer/presentations/pages/home_page/home_page.dart';
import 'package:wanderer/presentations/pages/user_order_list_page/user_order_list_page.dart';

import 'account_check_page.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  static const routeName = '/tabScreen';

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, dynamic>> _pages;
  int selectedIndex = 0;

  User? user;

  @override
  void initState() {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    user = firebaseAuth.currentUser;
    _pages = [
      {'page': HomePage(), 'title': 'home'},
      {'page': const CampervanPage(), 'title': 'Campervan'},
      {'page': const UserOrderListPage(), 'title': 'My Order'},
      {'page': HomePage(), 'title': 'Articles'},
      {
        'page': user == null ? const AccountCheckPage() : const AccountPage(),
        'title': 'My Self'
      },
    ];
    super.initState();
  }

  void selectedPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectedPage,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        selectedIconTheme: const IconThemeData(opacity: 0.1),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/img/tab_image/home.png",
              scale: 1.4,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/img/tab_image/car.png",
              scale: 1.4,
            ),
            label: "Campervan",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/img/tab_image/order.png",
              scale: 1.4,
            ),
            label: "My Order",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/img/tab_image/articles.png",
              scale: 1.4,
            ),
            label: "Articles",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/img/tab_image/account.png",
              scale: 1.4,
            ),
            label: "My Self",
          ),
        ],
      ),
    );
  }
}
