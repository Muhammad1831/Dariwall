import 'package:get_it/get_it.dart';
import 'package:ostad/providers/auth_provider.dart';
import 'package:ostad/providers/image_picker_provider.dart';
import 'package:ostad/providers/sign_up_provider.dart';
import 'package:ostad/services/api_client_service.dart';
import 'package:ostad/services/auth_service.dart';
import 'package:ostad/services/sign_up_service.dart';
import 'package:ostad/utils/app_shared_preferences.dart';

final getIt = GetIt.instance;

class LocatorService {
  static Future<void> init() async {
    await AppSharedPreferences.init();

    getIt.registerSingleton<AppSharedPreferences>(AppSharedPreferences.getInstance);

    getIt.registerLazySingleton<ApiClientService>(() => ApiClientService(getIt<AppSharedPreferences>()));

    getIt.registerFactory<ImagePickerProvider>(() => ImagePickerProvider());

    getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<ApiClientService>(), getIt<AppSharedPreferences>()));
    getIt.registerLazySingleton<AuthProvider>(() => AuthProvider(getIt<AuthService>()));
    
    getIt.registerLazySingleton<SignUpService>(() => SignUpService(getIt<ApiClientService>(), getIt<AppSharedPreferences>()));
    getIt.registerLazySingleton<SignUpProvider>(() => SignUpProvider(getIt<SignUpService>()));
  }
}