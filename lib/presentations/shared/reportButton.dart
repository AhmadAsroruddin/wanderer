import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wanderer/domain/entities/order.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import '../../data/models/report_model.dart';
import '../bloc/user_bloc.dart';

class ReportButton {
  static Future<dynamic> buttonReport(
      BuildContext context, OrderData orderData, TextEditingController report) {
    return showDialog(
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
                    fillColor: Colors.grey[200], // Warna latar belakang
                    contentPadding: const EdgeInsets.all(
                        16), // Padding teks di dalam TextField
                    border: OutlineInputBorder(
                      // Bentuk bulat
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      // Garis tepi saat tidak digunakan (bisa disesuaikan)
                      borderSide: BorderSide(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // Garis tepi saat fokus (bisa disesuaikan)
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                ElevatedButton(
                  onPressed: () async {
                    context.read<UserCubit>().report(
                          ReportModel(
                            report.text,
                            orderData.accountId,
                            orderData.id,
                            orderData.orderedPlaceId,
                          ),
                        );
                    Navigator.of(context).pop();
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'wanderermateid@gmail.com',
                      queryParameters: {
                        'subject': 'LAPORAN PENGGUNA',
                        'body': """
                                  REPORT ID     : 
                                  Order ID      : ${orderData.orderId}
                                  Ordered Place : ${orderData.orderedPlaceId}
                                  Guest Name    : ${orderData.guestName}
                                  
                                  ///////////PLEASE DON'T DELETE MESSAAGE ABOVE////////
                                  ${report.text}
                                """,
                      },
                    );

                    if (await canLaunchUrl(emailLaunchUri)) {
                      print("object");
                      await launchUrl(emailLaunchUri);
                    } else {
                      print("COULDN'T SEND EMAIL");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Warna latar belakang kuning
                    padding: const EdgeInsets.all(
                        16.0), // Atur padding untuk membuat tombol besar
                    minimumSize: Size(
                      deviceWidth * 0.4,
                      deviceHeight * 0.02,
                    ), // Lebar maksimum dengan tinggi 48.0
                  ),
                  child: Text(
                    'Tombol Besar',
                    style: whiteTextStyle.copyWith(
                      fontSize: deviceWidth * 0.04,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
