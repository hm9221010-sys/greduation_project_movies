import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class FirebaseUtils {
  static Future<UserCredential> createAccount({
    required String email,
    required String password,
  }) {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> resetPassword({
    required String email,
  }) {
    return FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
    );
  }
  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;

    await googleSignIn.initialize(
          serverClientId:
          '162007386982-otplm717ro41um7lpv5imia0qevgir3q.apps.googleusercontent.com',
    );

    final GoogleSignInAccount googleUser =
    await googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth =
        googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    final userCredential =
    await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    final user = userCredential.user;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(
        {
          'uid': user.uid,
          'name': user.displayName ?? '',
          'phone': '',
          'email': user.email ?? '',
          'avatar': 'assets/images/avatars/avatar_1.png',
        },
        SetOptions(
          merge: true,
        ),
      );
    }

    return userCredential;
  }

  static Future<void> saveUserData({
    required String uid,
    required String name,
    required String phone,
    required String email,
    required String avatar,
  }) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({
      'uid': uid,
      'name': name,
      'phone': phone,
      'email': email,
      'avatar': avatar,
    });
  }
  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
  }
  static Future<void> updateUserData({
    required String name,
    required String phone,
    required String avatar,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({
      'name': name,
      'phone': phone,
      'avatar': avatar,
    });
  }
  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
  static Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final uid = user.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .delete();

    await user.delete();
  }
}