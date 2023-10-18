import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wanderer/data/models/user_model.dart';
import 'package:wanderer/domain/entities/user.dart';

abstract class UserDataSource {
  Future<Users> getUserData();
}

class UserDataSourceImpl extends UserDataSource {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<Users> getUserData() async {
    String userId = firebaseAuth.currentUser!.uid;

    DocumentSnapshot doc =
        await firestore.collection('users').doc(userId).get();

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    Users users = UserModel.fromMap(data);

    return users;
  }
}
