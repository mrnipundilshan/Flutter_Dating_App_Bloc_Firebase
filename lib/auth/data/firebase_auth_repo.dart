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
  Future<AppUser?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) {
    // TODO: implement registerWithEmailAndPassword
    throw UnimplementedError();
  }
}
