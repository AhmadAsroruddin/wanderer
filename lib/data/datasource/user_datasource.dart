import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wanderer/data/models/user_model.dart';
import 'package:wanderer/domain/entities/user.dart';

abstract class UserDataSource {
  Future<Users> getUserData(String uid);
  Future<void> updateUserProfile(UserModel userData);
}

class UserDataSourceImpl extends UserDataSource {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
}
