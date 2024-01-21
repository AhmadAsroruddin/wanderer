import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wanderer/data/models/report_model.dart';
import 'package:wanderer/data/models/user_model.dart';
import 'package:wanderer/domain/entities/user.dart';

abstract class UserDataSource {
  Future<Users> getUserData(String uid);
  Future<void> updateUserProfile(UserModel userData);
  Future<void> reportSend(ReportModel report);
  Future<void> addToken();
}

class UserDataSourceImpl extends UserDataSource {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<Users> getUserData(String uid) async {
    DocumentSnapshot doc = await firestore.collection('users').doc(uid).get();

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    Users users = UserModel.fromMap(data);

    return users;
  }

  @override
  Future<void> updateUserProfile(UserModel userData) async {
    final currUser = firebaseAuth.currentUser;
    await currUser!.updateDisplayName(userData.username);
    await currUser.updateEmail(userData.email);
    await currUser.updatePhotoURL(userData.imageUrl);
    await firestore
        .collection('users')
        .doc(currUser.uid)
        .update(userData.toMap());
  }

  @override
  Future<void> reportSend(ReportModel report) async {
    firestore.collection("report").doc().set(report.toMap());
  }

  @override
  Future<void> addToken() async {
    String? token = await firebaseMessaging.getToken();
    print("FCM TOKEN : $token");

    firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .update({'token': token});
  }
}
