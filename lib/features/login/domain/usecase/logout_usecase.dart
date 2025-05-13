import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/utils/utils_shared_preferences.dart';

class LogoutUseCase {
  final UtilsSharedPreferences _preferences;

  LogoutUseCase(this._preferences);

  Future<void> call() async {
    await _preferences.clear();
    LocatorService.reset();
  }
}
