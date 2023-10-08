import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/data/datasource/auth_datasource.dart';
import 'package:wanderer/data/service/auth_repos_impl.dart';
import 'package:wanderer/domain/usecase/firstTimeDone.dart';
import 'package:wanderer/domain/usecase/isFirstTime.dart';
import 'package:wanderer/presentations/bloc/comment_bloc.dart';
import 'package:wanderer/presentations/bloc/favorite_bloc.dart';
import 'package:wanderer/presentations/bloc/location_data_cubit.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/bloc/toggle_boolean_bloc.dart';
import 'package:wanderer/presentations/shared/theme.dart';

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
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate routerDelegate;

  @override
  void initState() {
    super.initState();
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
  }

  // This widget is the root of your application.
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.light().copyWith(
          bottomNavigationBarTheme:
              BottomNavigationBarTheme.of(context).copyWith(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.black,
            backgroundColor: Colors.white,
            unselectedLabelStyle: blackTextStyle,
            selectedLabelStyle: blackTextStyle,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
          ),
        ),
        home: Router(
          routerDelegate: routerDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
        routes: {
          ResetPage.routeName: (context) => const ResetPage(),
        },
      ),
    );
  }
}
