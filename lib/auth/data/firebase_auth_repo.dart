import 'package:datingapp/auth/domain/entities/app_user.dart';
import 'package:datingapp/auth/domain/repository/auth_repository.dart';

class FirebaseAuthRepo implements AuthRepository {
  @override
  Future<AppUser?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> loginWithEmailAndPassword(String email, String password) {
    // TODO: implement loginWithEmailAndPassword
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
