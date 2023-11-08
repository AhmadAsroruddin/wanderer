import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/order_bloc.dart';
import 'package:wanderer/presentations/shared/cardManage.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class WaitingTabPage extends StatefulWidget {
  const WaitingTabPage(
      {required this.adminId,
      required this.isUser,
      required this.isNeddButton,
      super.key});
  final String adminId;
  final bool isUser;
  final bool isNeddButton;

  @override
  State<WaitingTabPage> createState() => _WaitingTabPageState();
}

class _WaitingTabPageState extends State<WaitingTabPage> {
  @override
  void initState() {
    if (mounted) {
      print("INI BISAHFIONAK;FJNADLKJFDSNFSDKLJFNKSDF");
      Future.delayed(Duration.zero, () async {
        await context
            .read<OrderCubit>()
            .getOrderDataByStatus(widget.adminId, "request", widget.isUser);
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderDataRequestObtained) {
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
                  isNeedButton: widget.isNeddButton,
                  widgetButton: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: deviceWidth * 0.3,
                        child: ElevatedButton(
                          onPressed: () async {
                            await context.read<OrderCubit>().updateStatus(
                                state.list[index].id,
                                widget.adminId,
                                "refused");
                            setState(() {});
                          },
                          child: const Text("Tolak"),
                        ),
                      ),
                      SizedBox(
                        width: deviceWidth * 0.3,
                        child: ElevatedButton(
                          onPressed: () async {
                            await context.read<OrderCubit>().updateStatus(
                                state.list[index].id,
                                widget.adminId,
                                "waiting");
                            setState(() {});
                          },
                          child: const Text("Terima"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      listener: (context, state) {},
    );
  }
}
