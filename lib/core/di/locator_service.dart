import 'package:get_it/get_it.dart';
import 'package:ostad/features/login/presentation/provider/auth_provider.dart';
import 'package:ostad/core/utils/image_picker_provider.dart';
import 'package:ostad/features/sign_up/presentation/provider/sign_up_provider.dart';
import 'package:ostad/core/services/api_client_service.dart';
import 'package:ostad/features/login/data/datasource/auth_service.dart';
import 'package:ostad/features/sign_up/data/datasource/sign_up_service.dart';
import 'package:ostad/core/utils/app_shared_preferences.dart';

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