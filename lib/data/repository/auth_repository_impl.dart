import 'package:flutter_soft_wars/core/utils/exceptions/error_handler.dart';
import 'package:flutter_soft_wars/data/datasources/local/data_providers/auth_data_provider.dart';
import 'package:flutter_soft_wars/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authDataProvider);

  final AuthDataProvider _authDataProvider;

  @override
  String? getEmail() {
    try {
      return _authDataProvider.getEmail();
    } catch (e, stackTrace) {
      ErrorHandler.handle(error: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> signInWithEmail(String email) async {
    try {
      await _authDataProvider.saveEmail(email);
    } catch (e, stackTrace) {
      ErrorHandler.handle(error: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _authDataProvider.clearEmail();
    } catch (e, stackTrace) {
      ErrorHandler.handle(error: e, stackTrace: stackTrace);
    }
  }
}
