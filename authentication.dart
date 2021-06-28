import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String userUid; // error shows redline in userUid
  String get getUserUid => userUid;
  

  Future<User?> logIntoAccount(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    User user = userCredential.user;  // error shows redline in userCredential.user
    userUid = user.uid;

    print(userUid);
    notifyListeners();
  }

  Future createAccount(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    User user = userCredential.user; // error shows redline in userCredential.user
    userUid = user.uid;

    print(userUid);
    notifyListeners();
  }

  Future logOutViaEmail() async {
    return firebaseAuth.signOut();
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();   // error showing on googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.idToken);

    final UserCredential userCredential =
        await firebaseAuth.signInWithCredential(authCredential);

    final User user = userCredential.user;  // error shows redline in userCredential.user

    assert(user.uid != null);
    userUid = user.uid;
    print('Google User Uid => $userUid');
    notifyListeners();
  }

  Future signOutWithGoogle() async {
    return googleSignIn.signOut();
  }
}
