import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wanderer/data/datasource/user_datasource.dart';
import 'package:wanderer/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<void> createUser(
      String username, String email, String password, String telponNumber);
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<void> signInWithGoogle();
  Future<void> resetPassword(String email);
}

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<void> createUser(String username, String email, String password,
      String telponNumber) async {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    await FirebaseFirestore.instance
        .collection("users")
        .doc(result.user!.uid)
        .set(UserModel(
                username: username,
                email: email,
                imageUrl:
                    "https://cdn.pixabay.com/photo/2023/05/21/07/47/horse-8008038_1280.jpg",
                telponNumber: telponNumber,
                markers: const [],
                role: "",
                token: "")
            .toMap());
  }

  @override
  Future<void> login(String email, String password) async {
    final userRepos = UserDataSourceImpl();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    userRepos.addToken();
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final UserDataSourceImpl userDataSource = UserDataSourceImpl();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

        if (!userDoc.exists) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .set(UserModel(
                      username: user.displayName!,
                      email: user.email!,
                      imageUrl:
                          "https://cdn.pixabay.com/photo/2023/05/21/07/47/horse-8008038_1280.jpg",
                      telponNumber: user.phoneNumber ?? "",
                      markers: const [],
                      role: "",
                      token: "")
                  .toMap());
        }
        await userDataSource.addToken();
      }
    }
  }

  //RESET PASSWORD
  @override
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
