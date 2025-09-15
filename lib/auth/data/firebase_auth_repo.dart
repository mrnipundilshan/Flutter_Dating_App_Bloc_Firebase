import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/auth/domain/entities/app_user.dart';
import 'package:datingapp/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo implements AuthRepository {
  // firebase auth instance
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // firebase firestore instance
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      // attempt tot sign up
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      // save user data in firestore
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .set(user.toJson());

      // return user
      return user;
    } catch (e) {
      throw Exception("Sign Up failed :$e");
    }
  }

  @override
  Future<AppUser?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      // attemt sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // fetch user document from firebase
      DocumentSnapshot userDoc = await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      // App user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: userDoc['name'],
      );

      return user;
    } catch (e) {
      // catch any errors
      Exception("Login failed: $e");
    }
    return null;
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    // get current logged in user from firebase
    final firebaseUser = firebaseAuth.currentUser;

    // if no user logged in
    if (firebaseUser == null) {
      return null;
    }

    // fetch user document from firebase
    DocumentSnapshot userDoc = await firebaseFirestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    // check if user doc exists
    if (!userDoc.exists) {
      return null;
    }

    // user exists
    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      name: userDoc['name'],
    );
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
