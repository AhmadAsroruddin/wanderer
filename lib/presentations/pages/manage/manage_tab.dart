import 'package:flutter/material.dart';
import 'package:wanderer/presentations/pages/manage/waiting_tab_page.dart';

import '../../shared/theme.dart';

class ManageTab extends StatelessWidget {
  const ManageTab({
    super.key,
    required this.adminId,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;
  final String adminId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: deviceHeight * 0.05,
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
                    text: "Booking",
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
                  WaitingTabPage(adminId: adminId),
                  Text("data 2"),
                  Text("data 3"),
                  Text("data 4")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
