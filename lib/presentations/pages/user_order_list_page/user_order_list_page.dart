import 'package:flutter/material.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import '../manage/waiting_payment_page.dart';
import '../manage/waiting_tab_page.dart';

class UserOrderListPage extends StatefulWidget {
  const UserOrderListPage({super.key});

  static const routeName = "/userOrderListPage";

  @override
  State<UserOrderListPage> createState() => _UserOrderListPageState();
}

class _UserOrderListPageState extends State<UserOrderListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String userId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pesanan Saya",
          style: blackTextStyle,
        ),
      ),
      body: SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.06,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    indicatorColor: Colors.amber,
                    isScrollable: true,
                    tabs: const [
                      Tab(
                        text: "Menunggu Konfirmasi",
                      ),
                      Tab(
                        text: "Menunggu Pembayaran",
                      ),
                      Tab(
                        text: "Aktif",
                      ),
                      Tab(
                        text: "Selesai",
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  width: deviceWidth,
                  height: deviceHeight * 0.5,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Isi tab 1
                      WaitingTabPage(
                        adminId: userId,
                        isUser: true,
                        isNeddButton: false,
                      ),
                      WaitingPaymentPage(
                        adminId: userId,
                        isUser: true,
                        isNeedButton: true,
                      ),
                      const Text("data 3"),
                      const Text("data 4")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
