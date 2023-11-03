import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wanderer/data/datasource/user_datasource.dart';
import 'package:wanderer/data/models/user_model.dart';
import 'package:wanderer/domain/entities/user.dart';

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
                role: "")
            .toMap());
  }

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;

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
      Users userRole = Users(
          username: "",
          email: "",
          imageUrl: "",
          telponNumber: "",
          markers: [],
          role: "");

      if (auth.currentUser!.uid == "") {
        print("asidlasndlasdla");
        UserDataSource dataSource = UserDataSourceImpl();

        userRole = await dataSource.getUserData();
      }

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .set(UserModel(
            username: user.displayName!,
            email: user.email!,
            imageUrl:
                "https://cdn.pixabay.com/photo/2023/05/21/07/47/horse-8008038_1280.jpg",
            telponNumber: user.phoneNumber ?? "",
            markers: const [],
            role: userRole.role == "" ? "" : userRole.role,
          ).toMap());
    }
  }

  //RESET PASSWORD
  @override
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
