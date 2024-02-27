import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wanderer/presentations/bloc/favorite_bloc.dart';
import 'package:wanderer/presentations/bloc/user_bloc.dart';
import 'package:wanderer/presentations/pages/edit_profile_page.dart';
import 'package:wanderer/presentations/pages/favorite_page.dart';
import 'package:wanderer/presentations/pages/manage/admin_page.dart';
import 'package:wanderer/presentations/pages/tab_screen.dart';
import 'package:wanderer/presentations/pages/user_order_list_page/user_order_list_page.dart';
import 'package:wanderer/presentations/pages/your_marker_page.dart';

import '../bloc/auth_bloc.dart';
import '../shared/CardAccount.dart';
import '../shared/theme.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  static const routeName = '/AccountPage';

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().getUser(FirebaseAuth.instance.currentUser!.uid);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          // Perbarui data atau ambil data baru dari server
          setState(() {});
        },
        child: SafeArea(
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserSuccess) {
                return SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(state.user.imageUrl),
                            radius: 100,
                          ),
                          SizedBox(
                            height: deviceHeight * 0.03,
                          ),
                          Text(
                            state.user.username,
                            style: GoogleFonts.roboto().copyWith(fontSize: 20),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.05,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  EditProfilePage.routeName,
                                  arguments: state.user);
                            },
                            child: CardAccount(
                              title: "Account",
                              deviceWidth: deviceWidth,
                              deviceHeight: deviceHeight,
                              child: AccountItem(
                                deviceWidth: deviceWidth,
                                deviceHeight: deviceHeight,
                                name: "Edit Profile",
                                image: "edit",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.05,
                          ),
                          CardAccount(
                            title: "Your necessity",
                            deviceWidth: deviceWidth,
                            deviceHeight: deviceHeight,
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    String userId = await context
                                        .read<AuthCubit>()
                                        .getCurrentUser();
                                    Navigator.of(context).pushNamed(
                                        UserOrderListPage.routeName,
                                        arguments: userId);
                                  },
                                  child: AccountItem(
                                    deviceWidth: deviceWidth,
                                    deviceHeight: deviceHeight,
                                    name: "My Order",
                                    image: "tab_image/order",
                                  ),
                                ),
                                const Divider(
                                  thickness: 2,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    FirebaseAuth firebaseAuth =
                                        FirebaseAuth.instance;
                                    String userId =
                                        firebaseAuth.currentUser!.uid;
                                    context
                                        .read<FavoriteCubit>()
                                        .getAllFav(userId);
                                    Navigator.of(context)
                                        .pushNamed(FavoritePage.routeName);
                                  },
                                  child: AccountItem(
                                    deviceWidth: deviceWidth,
                                    deviceHeight: deviceHeight,
                                    name: "My Favorite",
                                    image: "love",
                                  ),
                                ),
                                const Divider(
                                  thickness: 2,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    Navigator.of(context).pushNamed(
                                        YourMarkerPage.routeName,
                                        arguments: state.user);
                                  },
                                  child: AccountItem(
                                    deviceWidth: deviceWidth,
                                    deviceHeight: deviceHeight,
                                    name: "Your Marker",
                                    image: "marker",
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.03,
                          ),
                          state.user.role != ""
                              ? GestureDetector(
                                  onTap: () async {
                                    Navigator.of(context).pushNamed(
                                        AdminPage.routeName,
                                        arguments: state.user.role);
                                  },
                                  child: CardAccount(
                                    deviceWidth: deviceWidth,
                                    deviceHeight: deviceHeight,
                                    title: "Your Place",
                                    child: Column(
                                      children: <Widget>[
                                        AccountItem(
                                          deviceWidth: deviceWidth,
                                          deviceHeight: deviceHeight,
                                          image: "marker",
                                          name: "Manage",
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: deviceHeight * 0.08,
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await context.read<AuthCubit>().logout();
                              Navigator.of(context)
                                  .pushNamed(TabScreen.routeName);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: deviceWidth * 0.1,
                                    height: deviceHeight * 0.04,
                                    child: Image.asset(
                                      "assets/img/logout.png",
                                    ),
                                  ),
                                  SizedBox(
                                    width: deviceWidth * 0.1,
                                  ),
                                  Text(
                                    "Keluar",
                                    style: GoogleFonts.roboto()
                                        .copyWith(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class AccountItem extends StatelessWidget {
  const AccountItem(
      {super.key,
      required this.deviceWidth,
      required this.deviceHeight,
      required this.image,
      required this.name});

  final double deviceWidth;
  final double deviceHeight;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: deviceWidth * 0.1,
          height: deviceHeight * 0.04,
          child: Image.asset("assets/img/$image.png"),
        ),
        SizedBox(width: deviceWidth * 0.05),
        SizedBox(
          width: deviceWidth * 0.4,
          child: Text(
            name,
            style: GoogleFonts.roboto().copyWith(
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(width: deviceWidth * 0.15),
        SizedBox(
          height: deviceHeight * 0.04,
          child: Image.asset("assets/img/rightArrow.png"),
        ),
      ],
    );
  }
}
