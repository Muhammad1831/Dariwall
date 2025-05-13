import 'package:dariwall/core/utils/utils_shared_preferences.dart';

class CheckLoginUseCase {
  final UtilsSharedPreferences _preferences;

  CheckLoginUseCase(this._preferences);

  Future<bool> call() async {
    final token = await _preferences.getAccessToken();
    return token != null;
  }
}
