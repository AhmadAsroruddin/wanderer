import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import '../../domain/entities/order.dart';
import 'item_manage.dart';

class CardManage extends StatelessWidget {
  const CardManage({
    required this.orderData,
    required this.isNeedButton,
    required this.widgetButton,
    super.key,
  });

  final OrderData orderData;
  final bool isNeedButton;
  final Widget widgetButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth * 0.6,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: deviceHeight * 0.015,
            horizontal: deviceWidth * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: deviceWidth,
                child: Text(
                  "${orderData.name} x ${orderData.amountType} ",
                  style: blackTextStyle.copyWith(
                    fontSize: deviceWidth * 0.05,
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              SizedBox(
                width: deviceWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text("Check-in"),
                        Text(
                          orderData.firstDate,
                          style: blackTextStyle.copyWith(
                            fontSize: deviceWidth * 0.03,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(orderData.days.toString()),
                        const Icon(
                          FontAwesomeIcons.moon,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text("Check-out"),
                        Text(
                          orderData.lastDate,
                          style: blackTextStyle.copyWith(
                            fontSize: deviceWidth * 0.03,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Item(
                icon: FontAwesomeIcons.user,
                data: orderData.guestName,
              ),
              Item(
                icon: FontAwesomeIcons.moneyBill,
                data: orderData.price.toString(),
              ),
              Text(
                "Pesan Pemesan",
                style: blackTextStyle,
              ),
              Container(
                margin: EdgeInsets.only(bottom: deviceHeight * 0.008),
                child: Text(orderData.message),
              ),
              if (isNeedButton == true) widgetButton
            ],
          ),
        ),
      ),
    );
  }
}
