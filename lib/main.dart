import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wanderer/data/Api/firebaseApi.dart';
import 'package:wanderer/data/datasource/auth_datasource.dart';
import 'package:wanderer/data/service/auth_repos_impl.dart';
import 'package:wanderer/domain/usecase/firstTimeDone.dart';
import 'package:wanderer/domain/usecase/isFirstTime.dart';
import 'package:wanderer/presentations/bloc/admin_bloc.dart';
import 'package:wanderer/presentations/bloc/admin_data_bloc.dart';
import 'package:wanderer/presentations/bloc/article_bloc.dart';
import 'package:wanderer/presentations/bloc/comment_bloc.dart';
import 'package:wanderer/presentations/bloc/favorite_bloc.dart';
import 'package:wanderer/presentations/bloc/image_bloc.dart';
import 'package:wanderer/presentations/bloc/location_data_cubit.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/bloc/notification_bloc.dart';
import 'package:wanderer/presentations/bloc/order_bloc.dart';
import 'package:wanderer/presentations/bloc/payment_bloc.dart';
import 'package:wanderer/presentations/bloc/payout_bloc.dart';
import 'package:wanderer/presentations/bloc/toggle_boolean_bloc.dart';
import 'package:wanderer/presentations/bloc/type_bloc.dart';
import 'package:wanderer/presentations/bloc/user_bloc.dart';
import 'package:wanderer/presentations/shared/theme.dart';
import 'package:wanderer/presentations/pages/campervan_page/campervan_page.dart';

import './locator.dart' as di;
import 'package:wanderer/presentations/pages/auth/reset_page.dart';
import 'package:wanderer/presentations/routes/router_delegate.dart';

import 'firebase_options.dart';
import 'presentations/bloc/auth_bloc.dart';
import 'presentations/bloc/router_bloc.dart';

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'wanderer-3e072',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseApi().initNotifications();
  initializeDateFormatting("id_ID");
  runApp(InternetAwareApp());
}

class InternetAwareApp extends StatelessWidget {
  const InternetAwareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        bool isConnected = snapshot.data != ConnectivityResult.none;
        if (snapshot.connectionState == ConnectionState.active) {
          return MyApp(isConnected: isConnected);
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: AlertDialog(
                  title: Text('No Internet Connection'),
                  content: Text('Please check your internet connection'),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class MyApp extends StatefulWidget {
  final bool isConnected;

  const MyApp({Key? key, required this.isConnected}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate routerDelegate;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
      String? title = message.notification?.title;
      String? body = message.notification?.body;
      showNotification(title, body);
    });
    routerDelegate = MyRouterDelegate(
      RouterCubit(
        authUseCase: IsFirstTime(
          authRepos: AuthReposImpl(
              dataSource: AuthDataSourceImpl(),
              firebaseFirestore: FirebaseFirestore.instance),
        ),
        firstTimeDone: FirstTimeDone(
          authRepos: AuthReposImpl(
              dataSource: AuthDataSourceImpl(),
              firebaseFirestore: FirebaseFirestore.instance),
        ),
      ),
    );

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _showNoInternetDialog();
      } else {
        _hideNoInternetDialog();
      }
    });
  }

  Future<void> configureLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('wanderer', 'wanderer',
            importance: Importance.max, priority: Priority.high);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'data');
  }

  void _showNoInternetDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('No Internet Connection'),
      ),
    );
  }

  void _hideNoInternetDialog() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<AuthCubit>()),
        BlocProvider(create: (_) => di.locator<RouterCubit>()),
        BlocProvider(create: (_) => BooleanCubit()),
        BlocProvider(create: (_) => di.locator<LocationDataCubit>()),
        BlocProvider(create: (_) => di.locator<MarkersCubit>()),
        BlocProvider(create: (_) => di.locator<CommentCubit>()),
        BlocProvider(create: (_) => di.locator<FavoriteCubit>()),
        BlocProvider(create: (_) => di.locator<AdminCubit>()),
        BlocProvider(create: (_) => di.locator<ImageCubit>()),
        BlocProvider(create: (_) => di.locator<TypeCubit>()),
        BlocProvider(create: (_) => di.locator<AdminDataCubit>()),
        BlocProvider(create: (_) => di.locator<TypeCubitData>()),
        BlocProvider(create: (_) => di.locator<UserCubit>()),
        BlocProvider(create: (_) => di.locator<OrderCubit>()),
        BlocProvider(create: (_) => di.locator<PaymentCubit>()),
        BlocProvider(create: (_) => di.locator<ArticleCubit>()),
        BlocProvider(create: (_) => di.locator<PayoutCubit>()),
        BlocProvider(create: (_) => di.locator<NotificationCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.light().copyWith(
          // Theme data...
        ),
        home: Stack(
          children: [
            Router(
              routerDelegate: routerDelegate,
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
            if (!widget.isConnected)
              Positioned(
                bottom: 150,
                left: 20,
                right: 20,
                child: Container(
                  width: MediaQuery.of(context).size.width - 0.5,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Center(
                    child: Text(
                      'No Internet Connection',
                      style: TextStyle(color: Colors.white, fontSize: 14, decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ),
          ],
        ),
        routes: {
          ResetPage.routeName: (context) => ResetPage(),
          CampervanPage.routeName: (context) => CampervanPage(),
        },
      ),
    );
  }
}