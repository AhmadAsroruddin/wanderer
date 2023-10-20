import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import '../../bloc/admin_data_bloc.dart';
import 'manage_tab.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key, required this.adminId});
  final String adminId;
  static const routeName = '/AdminPage';

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)!.settings.arguments as String;

    context.read<AdminDataCubit>().getAdminData(userId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Halaman Pengelolaan",
          style: blackTextStyle,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<AdminDataCubit, AdminDataState>(
          builder: (context, state) {
            if (state is AdminDataSuccess) {
              return Column(
                children: <Widget>[
                  Container(
                    //PROFILE DATA
                    width: deviceWidth,
                    height: deviceHeight * 0.33,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: deviceWidth * 0.4,
                          height: deviceHeight * 0.2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                  state.data.image[0],
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          //NAME
                          width: deviceWidth * 0.7,
                          child: Center(
                            child: Text(
                              state.data.name,
                              style: blackTextStyle.copyWith(
                                fontSize: deviceWidth * 0.05,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth * 0.9,
                          child: Center(
                            child: Text(
                              state.data.address,
                              style: blackTextStyle.copyWith(
                                fontSize: deviceWidth * 0.034,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth * 0.9,
                          child: Center(
                            child: Text(
                              state.data.noTelp,
                              style: blackTextStyle.copyWith(
                                fontSize: deviceWidth * 0.034,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth * 0.9,
                          child: Center(
                            child: Text(
                              "Edit",
                              style: blueTextStyle.copyWith(
                                fontSize: deviceWidth * 0.034,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ),
                        //TAB ADMIN
                      ],
                    ),
                  ),
                  ManageTab(
                    tabController: _tabController,
                    adminId: state.data.id,
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
