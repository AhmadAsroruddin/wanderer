import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wanderer/data/datasource/auth_datasource.dart';
import '/domain/repositories/auth_repository.dart';

class AuthReposImpl implements AuthRepos {
  final AuthDataSource dataSource;
  final FirebaseFirestore firebaseFirestore;

  AuthReposImpl({required this.dataSource, required this.firebaseFirestore});

  @override
  Future<Either<String, dynamic>> createAccount(String username, String email,
      String password, String telponNumber) async {
    try {
      await dataSource.createUser(username, email, password, telponNumber);
      return const Right("Akun Berhasil Dibuat");
    } catch (e) {
      return Left("Error : $e");
    }
  }

  @override
  Future<Either<String, dynamic>> login(String email, String password) async {
    try {
      await dataSource.login(email, password);
      return const Right("Login berhasil");
    } catch (e) {
      return Left("$e");
    }
  }

  @override
  Future<Either<String, String>> logout() async {
    try {
      await dataSource.logout();
      return const Right("Logout Success");
    } catch (e) {
      return Left("$e");
    }
  }

  @override
  Future<Either<String, String>> signInWithGoogle() async {
    try {
      await dataSource.signInWithGoogle();
      return const Right("Berhasil");
    } catch (e) {
      print(e);
      return Left("$e");
    }
  }

  @override
  Future<Either<String, String>> resetPassword(String email) async {
    try {
      await dataSource.resetPassword(email);
      return const Right("Email reset kata sandi telah dikirim.");
    } catch (e) {
      return left("$e");
    }
  }

  @override
  Future<bool> isFirstTime() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool('firstTime') ?? true;
  }

  @override
  Future<void> gettingStartedDone() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('firstTime', false);
  }

  @override
  Future<String> getUserId() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final String userId = firebaseAuth.currentUser!.uid;
    return userId;
  }
}
