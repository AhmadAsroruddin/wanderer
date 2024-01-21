import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/data/models/report_model.dart';
import 'package:wanderer/domain/entities/bankAccount.dart';
import 'package:wanderer/presentations/bloc/order_bloc.dart';
import 'package:wanderer/presentations/bloc/payout_bloc.dart';
import 'package:wanderer/presentations/bloc/user_bloc.dart';
import 'package:wanderer/presentations/shared/cardManage.dart';
import 'package:wanderer/presentations/shared/customButton.dart';
import 'package:url_launcher/url_launcher.dart';

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
                        return CardManage(
                          orderData: orderData,
                          isNeedButton: widget.isNeedButton,
                          widgetButton: Column(
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    await context
                                        .read<OrderCubit>()
                                        .updateStatus(
                                            state.list[index].id,
                                            state.list[index].orderedPlaceId,
                                            "done");

                                    final Admin admin = await context
                                        .read<AdminDataCubit>()
                                        .getAdminDataReturn(
                                            state.list[index].orderedPlaceId);

                                    final BankAccount bankAccount = BankAccount(
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
                                  child: const CustomButton(name: "Check-in")),
                              SizedBox(
                                height: deviceHeight * 0.01,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: SizedBox(
                                          height: deviceHeight * 0.25,
                                          width: deviceWidth * .8,
                                          child: Column(
                                            children: <Widget>[
                                              TextField(
                                                controller: report,
                                                maxLines: 4,
                                                decoration: InputDecoration(
                                                  hintText: 'Masukkan teks',
                                                  filled: true,
                                                  fillColor: Colors.grey[
                                                      200], // Warna latar belakang
                                                  contentPadding: const EdgeInsets
                                                          .all(
                                                      16), // Padding teks di dalam TextField
                                                  border: OutlineInputBorder(
                                                    // Bentuk bulat
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    // Garis tepi saat tidak digunakan (bisa disesuaikan)
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.grey[200]!),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    // Garis tepi saat fokus (bisa disesuaikan)
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.blue),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: deviceHeight * 0.02,
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  context
                                                      .read<UserCubit>()
                                                      .report(
                                                        ReportModel(
                                                          report.text,
                                                          orderData.accountId,
                                                          orderData.id,
                                                          orderData
                                                              .orderedPlaceId,
                                                        ),
                                                      );
                                                  Navigator.of(context).pop();
                                                  final Uri emailLaunchUri =
                                                      Uri(
                                                    scheme: 'mailto',
                                                    path:
                                                        'wanderermateid@gmail.com',
                                                    queryParameters: {
                                                      'subject':
                                                          'LAPORAN PENGGUNA',
                                                      'body': report.text,
                                                    },
                                                  );

                                                  if (await canLaunchUrl(
                                                      emailLaunchUri)) {
                                                    print("object");
                                                    await launchUrl(
                                                        emailLaunchUri);
                                                  } else {
                                                    print(
                                                        "COULDN'T SEND EMAIL");
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .red, // Warna latar belakang kuning
                                                  padding: const EdgeInsets.all(
                                                      16.0), // Atur padding untuk membuat tombol besar
                                                  minimumSize: Size(
                                                    deviceWidth * 0.4,
                                                    deviceHeight * 0.02,
                                                  ), // Lebar maksimum dengan tinggi 48.0
                                                ),
                                                child: Text(
                                                  'Tombol Besar',
                                                  style: TextStyle(
                                                    fontSize:
                                                        deviceWidth * 0.04,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: deviceHeight * 0.05,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
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
