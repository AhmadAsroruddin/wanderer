import 'package:flutter/material.dart';
import 'package:wanderer/presentations/pages/manage/active_order_tab_page.dart';
import 'package:wanderer/presentations/pages/manage/waiting_payment_page.dart';
import 'package:wanderer/presentations/pages/manage/waiting_tab_page.dart';

import '../../shared/theme.dart';

class ManageTab extends StatelessWidget {
  const ManageTab(
      {super.key,
      required this.adminId,
      required TabController tabController,
      required this.isUser})
      : _tabController = tabController;

  final TabController _tabController;
  final String adminId;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              height: isUser == true ? deviceHeight * 0.86 : deviceHeight * 0.5,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Isi tab 1
                  WaitingTabPage(
                    adminId: adminId,
                    isNeddButton: true,
                    isUser: false,
                  ),
                  WaitingPaymentPage(
                    adminId: adminId,
                    isUser: false,
                    isNeedButton: false,
                  ),
                  ActiveOrderTabPage(
                    adminId: adminId,
                    isNeedButton: false,
                    isUser: isUser,
                  ),
                  const Text("data 4")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
