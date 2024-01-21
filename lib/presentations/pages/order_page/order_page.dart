import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wanderer/domain/entities/order.dart';
import 'package:wanderer/domain/entities/tipe.dart';
import 'package:wanderer/domain/entities/user.dart';
import 'package:wanderer/presentations/bloc/order_bloc.dart';
import 'package:wanderer/presentations/shared/customTextField.dart';
import 'package:wanderer/presentations/shared/dialogUtilsWithCustomRoute.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import '../../bloc/admin_data_bloc.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/notification_bloc.dart';
import '../user_order_list_page/user_order_list_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});
  static const routeName = '/OrderPage';

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController nama = TextEditingController();
  TextEditingController nomor = TextEditingController();
  TextEditingController permintaan = TextEditingController();
  Tipe? t;
  double harga = 0;
  int days = 1;

  DateTimeRange selectedDate = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(
      const Duration(days: 1),
    ),
  );

  String getMonthName(int month) {
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month - 1];
  }

  String formatDate(DateTime date) {
    final days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    final dayName = days[date.weekday - 1];
    final formattedDate =
        '$dayName, ${date.day} ${getMonthName(date.month)} ${date.year}';
    return formattedDate;
  }

  Future<void> selectedRange(
      BuildContext context, double price, int rooms) async {
    double hargaAkhir = 0;
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: selectedDate,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.black, // Ganti warna aksen menjadi hitam
            primaryTextTheme: const TextTheme(
              labelLarge:
                  TextStyle(color: Colors.black), // Ganti warna teks tombol
            ),
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      int numberOfDays = picked.end.difference(picked.start).inDays;
      hargaAkhir = ((price * rooms) * numberOfDays);
      setState(() {
        harga = hargaAkhir;
        days = numberOfDays;
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> data =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    Tipe tipe = data[0];
    int amount = data[1];
    String adminName = data[2];

    if (harga == 0) {
      setState(() {
        harga = ((tipe.price * amount));
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lengkapi Pesananmu",
          style: blackTextStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(230, 251, 252, .4)),
            padding: EdgeInsets.only(top: deviceHeight * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    width: deviceWidth * 0.9,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          //FIRST CARD COLUMN
                          children: <Widget>[
                            Row(
                              //buat gambar dan nama tempat
                              children: <Widget>[
                                Container(
                                  width: deviceWidth * 0.25,
                                  height: deviceHeight * 0.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        tipe.images[0],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: deviceWidth * 0.03,
                                ),
                                //COLUMN FOR PLACE NAME AND SELECTED TYPE
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        adminName,
                                        style: blackTextStyle.copyWith(
                                          fontSize: deviceWidth * 0.04,
                                          fontWeight: bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "$amount X ${tipe.name}",
                                        style: blackTextStyle.copyWith(
                                          fontSize: deviceWidth * 0.03,
                                          fontWeight: bold,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                            ),
                            SizedBox(
                              height: deviceHeight * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text("Check-in"),
                                    Text(
                                      formatDate(selectedDate.start),
                                      style: blackTextStyle.copyWith(
                                        fontSize: deviceWidth * 0.03,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )
                                  ],
                                ),
                                const Icon(
                                  FontAwesomeIcons.moon,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text("Check-out"),
                                    Text(
                                      formatDate(selectedDate.end),
                                      style: blackTextStyle.copyWith(
                                        fontSize: deviceWidth * 0.03,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () async {
                                  await selectedRange(
                                      context, tipe.price, amount);
                                },
                                child: const Text(
                                  "Pilih Tanggal",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: deviceWidth,
                              child: ListTile(
                                leading: const Icon(
                                  FontAwesomeIcons.user,
                                ),
                                title: Text("${tipe.capacity} Orang"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                const Title(name: "Detail Pemesanan"),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                Container(
                  width: deviceWidth,
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
                  child: SizedBox(
                    width: deviceWidth * 0.8,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.02,
                          horizontal: deviceWidth * 0.05,
                        ),
                        child: Column(
                          children: <Widget>[
                            CustomTextField(
                              screenSize: Size(deviceWidth, deviceHeight),
                              hintText: "Nama Pemesan",
                              icon: const Icon(FontAwesomeIcons.user),
                              label: "Nama Pemesan",
                              controller: nama,
                            ),
                            SizedBox(height: deviceHeight * 0.02),
                            CustomTextField(
                              screenSize: Size(deviceWidth, deviceHeight),
                              hintText: "Nomor Telpon",
                              icon: const Icon(FontAwesomeIcons.phone),
                              label: "Nomor Telepon",
                              controller: nomor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                const Title(
                  name: "Permintaan Khusus",
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                Container(
                  width: deviceWidth,
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
                  child: SizedBox(
                    width: deviceWidth * 0.8,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.02,
                          horizontal: deviceWidth * 0.05,
                        ),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: permintaan,
                              decoration: const InputDecoration(
                                hintText: "Tulis Permintaan di sini",
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration:
            const BoxDecoration(border: Border(top: BorderSide(width: 0.3))),
        child: BottomAppBar(
          child: Padding(
            padding: EdgeInsets.all(deviceWidth * .06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Rp.$harga",
                  style: blackTextStyle.copyWith(fontSize: deviceWidth * 0.05),
                ),
                SizedBox(
                  width: deviceWidth * 0.3,
                  child: BlocConsumer<OrderCubit, OrderState>(
                    listener: (context, state) {
                      if (state is OrderFailed) {
                        DialogUtilsWithCustomRoute.alertDialogWithCustomRoute(
                            context, "Gagal membuat pesanan", state.error, () {
                          Navigator.of(context).pop();
                        });
                      } else if (state is OrderSuccess) {
                        Navigator.of(context).pushNamed(
                          UserOrderListPage.routeName,
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              baseColor, // Warna latar belakang tombol
                          // Ubah warna teks di sini
                        ),
                        onPressed: () async {
                          String accountId =
                              await context.read<AuthCubit>().getCurrentUser();
                          await context.read<OrderCubit>().makeOrder(
                                OrderData(
                                    id: '',
                                    accountId: accountId,
                                    guestName: nama.text,
                                    orderedPlaceId: tipe.adminId,
                                    firstDate: formatDate(selectedDate.start),
                                    lastDate: formatDate(selectedDate.end),
                                    days: days,
                                    price: harga,
                                    status: 'request',
                                    message: permintaan.text,
                                    name: tipe.name,
                                    amountType: amount,
                                    orderId: ""),
                              );

                          Navigator.of(context)
                              .pushNamed(UserOrderListPage.routeName);
                          Users userAdmin = await context
                              .read<AdminDataCubit>()
                              .getAdminUser(tipe.adminId);

                          await context
                              .read<NotificationCubit>()
                              .sendNotification(userAdmin.token,
                                  "PESANAN MASUK", "TERDAPAT PESANAN");
                        },
                        child: state is OrderLoading
                            ? const CircularProgressIndicator.adaptive()
                            : Text(
                                "Pesan",
                                style: blackTextStyle.copyWith(
                                    fontSize: deviceWidth * 0.045),
                              ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    required this.name,
    super.key,
  });

  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.058),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          name,
          style: blackTextStyle.copyWith(
              fontSize: deviceWidth * 0.05, fontWeight: bold),
        ),
      ),
    );
  }
}
