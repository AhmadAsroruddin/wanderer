import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/order_bloc.dart';
import 'package:wanderer/presentations/shared/cardManage.dart';

import '../../shared/theme.dart';

class DoneOrderPage extends StatefulWidget {
  const DoneOrderPage({
    super.key,
    required this.adminId,
    required this.isUser,
    required this.isNeedButton,
  });

  final String adminId;
  final bool isUser;
  final bool isNeedButton;
  @override
  State<DoneOrderPage> createState() => _DoneOrderPageState();
}

class _DoneOrderPageState extends State<DoneOrderPage> {
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        await context
            .read<OrderCubit>()
            .getOrderDataByStatus(widget.adminId, "done", widget.isUser);
        super.initState();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderDataDoneObtained) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: deviceHeight * 0.02,
              horizontal: deviceWidth * 0.03,
            ),
            decoration: BoxDecoration(color: lightBackgroundColor),
            child: ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                return CardManage(
                  orderData: state.list[index],
                  isNeedButton: false,
                  widgetButton: Container(),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: Text("No data Yet"),
          );
        }
      },
    );
  }
}
