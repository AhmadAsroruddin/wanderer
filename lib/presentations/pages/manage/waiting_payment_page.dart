import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/transactionStatus.dart';
import 'package:wanderer/presentations/bloc/order_bloc.dart';
import 'package:wanderer/presentations/bloc/payment_bloc.dart';
import 'package:wanderer/presentations/shared/snapWebView.dart';

import '../../../domain/entities/order.dart';
import '../../shared/cardManage.dart';
import '../../shared/theme.dart';

class WaitingPaymentPage extends StatefulWidget {
  const WaitingPaymentPage(
      {required this.adminId,
      required this.isNeedButton,
      required this.isUser,
      super.key});

  final String adminId;
  final bool isUser;
  final bool isNeedButton;

  @override
  State<WaitingPaymentPage> createState() => _WaitingPaymentPageState();
}

class _WaitingPaymentPageState extends State<WaitingPaymentPage> {
  String transactionId = "";

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        await context
            .read<OrderCubit>()
            .getOrderDataByStatus(widget.adminId, "waiting", widget.isUser);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) async {
        if (state is OrderDataWaitingPaymentObtained) {
          for (var element in state.list) {
            TransactionStatus tStatus =
                await context.read<PaymentCubit>().getResponse(element.orderId);

            if (tStatus.transactionStatus == "settlement") {
              context
                  .read<OrderCubit>()
                  .updateStatus(element.id, element.orderedPlaceId, "paid");
              setState(() {});
            }
          }
        }
      },
      builder: (context, state) {
        if (state is OrderDataWaitingPaymentObtained) {
          print('data sadas ${state.list}');
          if (state.list == []) {
            return const Center(
              child: Text("Belum ada pesanan"),
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
                  final price = state.list[index].price;
                  OrderData orderData = state.list[index];

                  return CardManage(
                    orderData: state.list[index],
                    isNeedButton: widget.isNeedButton,
                    widgetButton: Container(
                      width: deviceWidth,
                      child: BlocConsumer<PaymentCubit, PaymentState>(
                        listener: (context, state) {
                          if (state is PaymentUrls) {
                            Navigator.of(context).pushNamed(
                                SnapWebViewScreen.routeName,
                                arguments: {'url': state.url.redirectUrl});
                          } else if (state is PaymentFailed) {
                            print(state.error);
                          } else {
                            print("LOADING");
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              context
                                  .read<PaymentCubit>()
                                  .getUrl(price, orderData);
                            },
                            child: const Text("Bayar"),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
