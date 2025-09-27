/*

Auth Repository - outlines the possible auth operaions for this app 

*/

import 'package:datingapp/features/auth/domain/entities/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> loginWithEmailAndPassword(String email, String password);

  Future<AppUser?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  );

  Future<void> logout();

  Future<AppUser?> getCurrentUser();
}
