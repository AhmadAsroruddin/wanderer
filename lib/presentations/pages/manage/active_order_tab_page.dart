import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/order_bloc.dart';
import 'package:wanderer/presentations/shared/cardManage.dart';

import '../../../domain/entities/order.dart';
import '../../shared/theme.dart';

class ActiveOrderTabPage extends StatelessWidget {
  const ActiveOrderTabPage(
      {required this.adminId,
      required this.isNeedButton,
      required this.isUser,
      super.key});

  final String adminId;
  final bool isUser;
  final bool isNeedButton;

  @override
  Widget build(BuildContext context) {
    context.read<OrderCubit>().getOrderDataByStatus(adminId, "paid", isUser);
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderDataObtained) {
          if (state.list == []) {
            print("object");
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
                    isNeedButton: isNeedButton,
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
