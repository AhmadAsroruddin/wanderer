import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wanderer/domain/entities/bankAccount.dart';
import 'package:wanderer/presentations/bloc/order_bloc.dart';
import 'package:wanderer/presentations/bloc/payout_bloc.dart';
import 'package:wanderer/presentations/shared/cardManage.dart';
import 'package:wanderer/presentations/shared/customButton.dart';

import 'package:wanderer/presentations/shared/reportButton.dart';

import '../../../domain/entities/admin.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/entities/user.dart';
import '../../bloc/admin_data_bloc.dart';
import '../../bloc/notification_bloc.dart';
import '../../shared/theme.dart';
import '../../shared/utils.dart';

class ActiveOrderTabPage extends StatefulWidget {
  const ActiveOrderTabPage(
      {required this.adminId,
      required this.isNeedButton,
      required this.isUser,
      this.isThisAdmin = false,
      super.key});

  final String adminId;
  final bool isUser;
  final bool isNeedButton;
  final bool isThisAdmin;

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

  TextEditingController report = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrderCubit>(context)
        .getOrderDataByStatus(widget.adminId, "paid", widget.isUser);
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderDataPaidObtained) {
          if (state.list == []) {
            return const Center(
              child: Text("Belum ada Pesanan"),
            );
          } else {
            return Column(
              children: <Widget>[
                widget.isUser == false
                    ? Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: deviceWidth * 0.03,
                        ),
                        padding: const EdgeInsets.all(15),
                        height: deviceHeight * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Saat melakukan check-in, pastikan pemesan menekan tombol check-in",
                            style: whiteTextStyle,
                          ),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceHeight * 0.02,
                      horizontal: deviceWidth * 0.03,
                    ),
                    child: ListView.builder(
                      itemCount: state.list.length,
                      itemBuilder: (context, index) {
                        OrderData orderData = state.list[index];
                        bool isgestureEnabled = false;
                        // String input
                        String inputDate = orderData.firstDate;

                        // Mendefinisikan formatter untuk mengurai string input
                        DateFormat inputFormatter = DateFormat.EEEE('id_ID')
                            .addPattern(', d MMMM yyyy');

                        // Parse string input menjadi objek DateTime
                        DateTime targetDate =
                            inputFormatter.parseLoose(inputDate);

                        // Dapatkan tanggal dan bulan hari ini
                        DateTime currentDate = DateTime.now();
                        int currentDay = currentDate.day;
                        int currentMonth = currentDate.month;

                        // Bandingkan tanggal dan bulan target dengan tanggal dan bulan hari ini
                        int comparisonResult = targetDate.compareTo(DateTime(
                            currentDate.year, currentMonth, currentDay + 1));

                        if (comparisonResult < 0) {
                          isgestureEnabled = true;
                        } else if (comparisonResult > 0) {
                          isgestureEnabled = false;
                        } else {
                          isgestureEnabled = true;
                        }

                        return CardManage(
                          orderData: orderData,
                          isNeedButton: widget.isNeedButton,
                          widgetButton: Column(
                            children: [
                              isgestureEnabled == false
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () async {
                                        await context
                                            .read<OrderCubit>()
                                            .updateStatus(
                                                state.list[index].id,
                                                state
                                                    .list[index].orderedPlaceId,
                                                "done");

                                        final Admin admin = await context
                                            .read<AdminDataCubit>()
                                            .getAdminDataReturn(state
                                                .list[index].orderedPlaceId);

                                        final BankAccount bankAccount =
                                            BankAccount(
                                                name: admin.nameRek,
                                                account: admin.noRek,
                                                bank: admin.bankRek,
                                                aliasName: admin.aliasNameRek,
                                                email: admin.emailRek);

                                        final payoutId = await context
                                            .read<PayoutCubit>()
                                            .createPayoutBloc(
                                                bankAccount,
                                                orderData.price.toString(),
                                                "Payout dari ${orderData.guestName}");

                                        context
                                            .read<PayoutCubit>()
                                            .approvePayout(payoutId);
                                        Users userAdmin = await context
                                            .read<AdminDataCubit>()
                                            .getAdminUser(admin.id);

                                        await context
                                            .read<NotificationCubit>()
                                            .sendNotification(
                                                userAdmin.token,
                                                "Check-in Berhasil",
                                                "Telah berhasil check in, silahkan buka email anda untuk  mendapatkan invoice");
                                        setState(() {});
                                      },
                                      child:
                                          const CustomButton(name: "Check-in")),
                              SizedBox(
                                height: deviceHeight * 0.01,
                              ),
                              widget.isThisAdmin == false
                                  ? GestureDetector(
                                      onTap: () {
                                        ReportButton.buttonReport(
                                            context, orderData, report);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: deviceHeight * 0.05,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Report",
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2125,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
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
