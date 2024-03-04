import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/bankAccount.dart';
import 'package:wanderer/presentations/bloc/admin_bloc.dart';
import 'package:wanderer/presentations/bloc/payout_bloc.dart';
import 'package:wanderer/presentations/pages/admin_page/location_details_page.dart';
import 'package:wanderer/presentations/pages/admin_page/step2_page.dart';
import 'package:wanderer/presentations/shared/alertDialog.dart';
import 'package:wanderer/presentations/shared/customButton.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class AddPayoutPage extends StatelessWidget {
  const AddPayoutPage({super.key});

  static const routeName = '/addPayoutPage';

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController number = TextEditingController();
    TextEditingController bankName = TextEditingController();
    TextEditingController aliasName = TextEditingController();
    TextEditingController email = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bank Account",
          style: blackTextStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(deviceWidth * 0.02),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  "Please fill this form correctly. We will transfer your money to this bank account",
                  style: TextStyle(fontSize: deviceWidth * 0.04),
                ),
                SizedBox(
                  height: deviceHeight * 0.04,
                ),
                CustomTextField(
                  hintText: "Name",
                  controller: name,
                  onChanged: (index) {},
                ),
                CustomTextField(
                  hintText: "Account Number",
                  controller: number,
                  onChanged: (p0) {},
                ),
                CustomTextField(
                  hintText: "Bank Name",
                  controller: bankName,
                  onChanged: (p0) {},
                ),
                CustomTextField(
                  hintText: "Alias Name",
                  controller: aliasName,
                  onChanged: (p0) {},
                ),
                CustomTextField(
                  hintText: "Email",
                  controller: email,
                  onChanged: (p0) {},
                ),
                GestureDetector(
                  onTap: () async {
                    if (name.text.isNotEmpty &&
                        number.text.isNotEmpty &&
                        bankName.text.isNotEmpty &&
                        aliasName.text.isNotEmpty &&
                        email.text.isNotEmpty) {
                      final bankAccount = BankAccount(
                          name: name.text,
                          account: number.text,
                          bank: bankName.text,
                          aliasName: aliasName.text,
                          email: email.text);
                      context.read<AdminCubit>().setBank(bankAccount);
                      await context
                          .read<PayoutCubit>()
                          .createBeneficaries(bankAccount);
                      Navigator.of(context)
                          .pushReplacementNamed(Step2Page.routeName);
                    } else {
                      DialogUtils.alertDialog(
                          context, "Warning", "Please Fill up all form above");
                    }
                  },
                  child: const CustomButton(name: "Next"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
