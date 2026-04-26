abstract class AuthRepository {
  String? getEmail();

  Future<void> signInWithEmail(String email);

  Future<void> signOut();
}
