import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _Keys {
  static const emailKey = 'email';
}

@Injectable()
class AuthDataProvider {
  AuthDataProvider(this._prefs);

  final SharedPreferences _prefs;

  String? getEmail() {
    final email = _prefs.getString(_Keys.emailKey);
    return email;
  }

  Future<void> saveEmail(String email) => _prefs.setString(_Keys.emailKey, email.trim());

  Future<void> clearEmail() => _prefs.remove(_Keys.emailKey);
}
