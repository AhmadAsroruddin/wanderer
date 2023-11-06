import 'package:flutter/material.dart';

import 'package:wanderer/presentations/bloc/router_bloc.dart';
import 'package:wanderer/presentations/pages/account_page.dart';
import 'package:wanderer/presentations/pages/admin_page/addLocation.dart';
import 'package:wanderer/presentations/pages/admin_page/addPhoto_page.dart';
import 'package:wanderer/presentations/pages/admin_page/addType_page.dart';
import 'package:wanderer/presentations/pages/admin_page/chooseType_page.dart';
import 'package:wanderer/presentations/pages/admin_page/facilities_page.dart';
import 'package:wanderer/presentations/pages/admin_page/getStarted_page.dart';
import 'package:wanderer/presentations/pages/admin_page/location_details_page.dart';
import 'package:wanderer/presentations/pages/admin_page/step1_page.dart';
import 'package:wanderer/presentations/pages/admin_page/step2_page.dart';

import 'package:wanderer/presentations/pages/auth/login_page.dart';
import 'package:wanderer/presentations/pages/auth/register_page.dart';
import 'package:wanderer/presentations/pages/auth/resetConfirmation.dart';
import 'package:wanderer/presentations/pages/auth/reset_page.dart';
import 'package:wanderer/presentations/pages/edit_profile_page.dart';
import 'package:wanderer/presentations/pages/favorite_page.dart';
import 'package:wanderer/presentations/pages/getStarted/first_page.dart';
import 'package:wanderer/presentations/pages/getStarted/third_page.dart';
import 'package:wanderer/presentations/pages/add_marker/maps_page.dart';
import 'package:wanderer/presentations/pages/add_marker/marker_category.dart';
import 'package:wanderer/presentations/pages/manage/admin_page.dart';
import 'package:wanderer/presentations/pages/marker_page/marker_paget.dart';
import 'package:wanderer/presentations/pages/order_page/order_page.dart';
import 'package:wanderer/presentations/pages/splashScreen.dart';
import 'package:wanderer/presentations/pages/tab_screen.dart';
import 'package:wanderer/presentations/pages/add_marker/tambah_marker.dart';
import 'package:wanderer/presentations/pages/user_order_list_page/user_order_list_page.dart';
import 'package:wanderer/presentations/shared/search_page.dart';
import 'package:wanderer/presentations/shared/snapWebView.dart';
import '../../domain/entities/marker.dart';
import '../pages/admin_page/step3_page.dart';
import '../pages/getStarted/second_page.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  bool? isFirstTime;

  //THIS IS FOR ROUTING GETTING STARTED
  bool second = false;
  bool third = false;

  String categoryName = "";
  Markers marker = const Markers(
      name: "name",
      description: "description",
      image: [],
      jenis: "jenis",
      latitude: 0,
      longitude: 0,
      userId: "userId",
      contact: "contact",
      socialMedia: "socialMedia",
      address: "",
      harga: "");

  final RouterCubit routerCubit;

  MyRouterDelegate(this.routerCubit)
      : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        await routerCubit.checkLoginStatus();
        isFirstTime = routerCubit.state;
        notifyListeners();
      },
    );
  }

  List<Page> _historyStack = [];

  @override
  Widget build(BuildContext context) {
    if (isFirstTime == null) {
      _historyStack = _splashScreen;
    } else if (isFirstTime == true) {
      _historyStack = _gettingStartedStack;
    } else {
      _historyStack = _loggedOutStack;
    }

    return Navigator(
      key: navigatorKey,
      pages: _historyStack,
      onGenerateRoute: (settings) {
        if (settings.name == ResetPage.routeName) {
          return MaterialPageRoute(
            builder: (context) => const ResetPage(),
            settings: settings,
          );
        }
        if (settings.name == RegisterPage.routeName) {
          return MaterialPageRoute(
            builder: (context) => const RegisterPage(),
            settings: settings,
          );
        }

        if (settings.name == ResetConfirmation.routeName) {
          return MaterialPageRoute(
              builder: (context) => const ResetConfirmation(),
              settings: settings);
        }
        if (settings.name == LoginPage.routeName) {
          return MaterialPageRoute(
            builder: (context) => const LoginPage(),
            settings: settings,
          );
        }
        if (settings.name == TabScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const TabScreen(),
            settings: settings,
          );
        }
        if (settings.name == MarkerCategoryPage.routeName) {
          return MaterialPageRoute(
            builder: (context) => MarkerCategoryPage(),
            settings: settings,
          );
        }
        if (settings.name == AddMarkerPage.routeName) {
          return MaterialPageRoute(
            builder: (context) => AddMarkerPage(
              category: categoryName,
            ),
            settings: settings,
          );
        }
        if (settings.name == MapFullPage.routeName) {
          return MaterialPageRoute(
            builder: (context) => const MapFullPage(),
            settings: settings,
          );
        }
        if (settings.name == MarkerPage.routeName) {
          return MaterialPageRoute(
            builder: (context) => const MarkerPage(),
            settings: settings,
          );
        }
        if (settings.name == FavoritePage.routeName) {
          return MaterialPageRoute(
            builder: (context) => const FavoritePage(),
            settings: settings,
          );
        }
        if (settings.name == GetStartedWandererPage.routeName) {
          return MaterialPageRoute(
            builder: (context) => const GetStartedWandererPage(),
            settings: settings,
          );
        }
        if (settings.name == Step1Page.routeName) {
          return MaterialPageRoute(
            builder: (context) => const Step1Page(),
            settings: settings,
          );
        }
        if (settings.name == AddLocation.routeName) {
          return MaterialPageRoute(
            builder: (context) => const AddLocation(),
            settings: settings,
          );
        }

        if (settings.name == LocationDetailsPage.routeName) {
          return MaterialPageRoute(
              builder: (context) => const LocationDetailsPage(),
              settings: settings);
        }
        if (settings.name == AddTypePage.routeName) {
          return MaterialPageRoute(
              builder: (context) => const AddTypePage(), settings: settings);
        }
        if (settings.name == ChooseTypePage.routeName) {
          return MaterialPageRoute(
              builder: (context) => const ChooseTypePage(), settings: settings);
        }
        if (settings.name == Step2Page.routeName) {
          return MaterialPageRoute(
              builder: (context) => const Step2Page(), settings: settings);
        }
        if (settings.name == Step3Page.routeName) {
          return MaterialPageRoute(
              builder: (context) => const Step3Page(), settings: settings);
        }
        if (settings.name == FacilitiesPage.routeName) {
          return MaterialPageRoute(
              builder: (context) => const FacilitiesPage(), settings: settings);
        }
        if (settings.name == AddPhotoPage.routeName) {
          return MaterialPageRoute(
              builder: (context) => const AddPhotoPage(), settings: settings);
        }
        if (settings.name == AdminPage.routeName) {
          return MaterialPageRoute(
              builder: (context) => const AdminPage(
                    adminId: "",
                  ),
              settings: settings);
        }
        if (settings.name == OrderPage.routeName) {
          return MaterialPageRoute(
              builder: (context) => const OrderPage(), settings: settings);
        }
        if (settings.name == UserOrderListPage.routeName) {
          return MaterialPageRoute(
              builder: (context) => const UserOrderListPage(),
              settings: settings);
        }
        if (settings.name == SnapWebViewScreen.routeName) {
          return MaterialPageRoute(
              builder: (context) => const SnapWebViewScreen(),
              settings: settings);
        }
        if (settings.name == SearchPage.routeName) {
          return MaterialPageRoute(
              builder: (context) => const SearchPage(), settings: settings);
        }
        if (settings.name == EditProfilePage.routeName) {
          return MaterialPageRoute(
              builder: (context) => const EditProfilePage(),
              settings: settings);
        }
        if (settings.name == AccountPage.routeName) {
          return MaterialPageRoute(
              builder: (context) => const AccountPage(), settings: settings);
        }

        return null;
      },
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }
        notifyListeners();
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }

  void nextSecond() {
    second = true;
    notifyListeners();
  }

  void nextThird() {
    third = true;
    second = false;
    notifyListeners();
  }

  void firstTimeDone() {
    isFirstTime = false;
    routerCubit.firstTimeFalse();
    notifyListeners();
  }

  void addCategory(String category) {
    categoryName = category;
    notifyListeners();
  }

  List<Page> get _gettingStartedStack => [
        const MaterialPage(
          key: ValueKey('firstPage'),
          child: GettingStartedFirst(),
        ),
        if (second == true)
          const MaterialPage(
            key: ValueKey('secondPage'),
            child: GettingStartedSecond(),
          ),
        if (third == true)
          const MaterialPage(
            key: ValueKey('thirdPage'),
            child: GettingStartedThird(),
          ),
      ];

  List<Page> get _loggedOutStack => [
        const MaterialPage(key: ValueKey('tabscreen'), child: TabScreen()),
      ];

  List<Page> get _splashScreen => [
        const MaterialPage(
          key: ValueKey('value'),
          child: SplashScreen(),
        ),
      ];
}
