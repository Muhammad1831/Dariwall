import 'package:get_it/get_it.dart';
import 'package:ostad/features/create_new_wallet/domain/repository/create_wallet_repository.dart';
import 'package:ostad/core/utils/utils_image_picker_provider.dart';
import 'package:ostad/features/sign_up/presentation/provider/sign_up_provider.dart';
import 'package:ostad/core/services/api_client_service.dart';
import 'package:ostad/features/login/data/datasource/auth_service.dart';
import 'package:ostad/features/sign_up/data/datasource/sign_up_service.dart';
import 'package:ostad/core/utils/utils_shared_preferences.dart';
import 'package:ostad/features/create_new_wallet/data/datasource/create_wallet_datasource.dart';
import 'package:ostad/features/create_new_wallet/data/repository/create_wallet_repository_imp.dart';
import 'package:ostad/features/create_new_wallet/domain/usecase/create_wallet_usecase.dart';
import 'package:ostad/features/create_new_wallet/presentation/provider/create_wallet_provider.dart';

final getIt = GetIt.instance;

class LocatorService {
  static Future<void> init() async {
    await UtilsSharedPreferences.init();

    getIt.registerSingleton<UtilsSharedPreferences>(UtilsSharedPreferences.getInstance);

    getIt.registerLazySingleton<ApiClientService>(() => ApiClientService(getIt<UtilsSharedPreferences>()));

    getIt.registerFactory<UtilsImagePickerProvider>(() => UtilsImagePickerProvider());

    getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<ApiClientService>(), getIt<UtilsSharedPreferences>()));
    
    getIt.registerLazySingleton<SignUpService>(() => SignUpService(getIt<ApiClientService>(), getIt<UtilsSharedPreferences>()));
    getIt.registerLazySingleton<SignUpProvider>(() => SignUpProvider(getIt<SignUpService>()));

    // Register CreateWallet dependencies
    getIt.registerLazySingleton<CreateWalletDatasource>(() => CreateWalletDatasource(getIt<ApiClientService>(), getIt<UtilsSharedPreferences>()));
    getIt.registerLazySingleton<CreateWalletRepository>(() => CreateWalletRepositoryImpl(datasource: getIt<CreateWalletDatasource>()));
    getIt.registerLazySingleton<CreateWalletUsecase>(() => CreateWalletUsecase(createWalletRepository: getIt<CreateWalletRepository>()));
    getIt.registerLazySingleton<CreateWalletProvider>(() => CreateWalletProvider(createWalletUsecase: getIt<CreateWalletUsecase>()));
  }
}