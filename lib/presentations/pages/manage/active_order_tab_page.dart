import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/order_bloc.dart';
import 'package:wanderer/presentations/shared/cardManage.dart';

import '../../../domain/entities/order.dart';
import '../../shared/theme.dart';

class ActiveOrderTabPage extends StatefulWidget {
  const ActiveOrderTabPage(
      {required this.adminId,
      required this.isNeedButton,
      required this.isUser,
      super.key});

  final String adminId;
  final bool isUser;
  final bool isNeedButton;

  @override
  State<ActiveOrderTabPage> createState() => _ActiveOrderTabPageState();
}

class _ActiveOrderTabPageState extends State<ActiveOrderTabPage> {
  @override
  void initState() {
    context
        .read<OrderCubit>()
        .getOrderDataByStatus(widget.adminId, "paid", widget.isUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderDataPaidObtained) {
          if (state.list == []) {
            return const Center(
              child: Text("Belum ada Pesanan"),
            );
          } else {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.02,
                horizontal: deviceWidth * 0.03,
              ),
              child: ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  OrderData orderData = state.list[index];
                  return CardManage(
                    orderData: orderData,
                    isNeedButton: widget.isNeedButton,
                    widgetButton: Container(),
                  );
                },
              ),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
