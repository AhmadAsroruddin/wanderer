import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/auth_bloc.dart';
import 'package:wanderer/presentations/pages/manage/active_order_tab_page.dart';
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
  String userId = "";

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    Future.delayed(
      Duration.zero,
      () async {
        String dataId = await context.read<AuthCubit>().getCurrentUser();
        setState(() {
          userId = dataId;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pesanan Saya",
          style: blackTextStyle,
        ),
      ),
      body: SafeArea(
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
                height: deviceHeight * 0.85,
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
                    ActiveOrderTabPage(
                      adminId: userId,
                      isNeedButton: true,
                      isUser: true,
                    ),
                    const Text("data 4")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
