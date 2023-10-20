import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/order_bloc.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class WaitingTabPage extends StatelessWidget {
  const WaitingTabPage({required this.adminId, super.key});
  final String adminId;

  @override
  Widget build(BuildContext context) {
    context.read<OrderCubit>().getOrderDataByStatus(adminId, "request");
    return BlocConsumer<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderDataObtained) {
          return ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return Text("asd");
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      listener: (context, state) {},
    );
  }
}
