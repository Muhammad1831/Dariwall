import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/widgets/app_snack_bar.dart';
import 'package:dariwall/features/create_new_wallet/domain/usecase/create_wallet_usecase.dart';
import 'package:dariwall/features/create_new_wallet/presentation/provider/create_wallet_provider.dart';
import 'package:dariwall/features/home/presentation/provider/my_balances_provider.dart';
import 'package:dariwall/features/login/domain/usecase/check_login_usecase.dart';
import 'package:dariwall/features/login/domain/usecase/login_with_email_usecase.dart';
import 'package:dariwall/features/login/domain/usecase/login_with_keys_usecase.dart';
import 'package:dariwall/features/login/domain/usecase/logout_usecase.dart';
import 'package:dariwall/features/login/domain/usecase/verify_email_code_usecase.dart';
import 'package:dariwall/features/login/presentation/provider/login_provider.dart';
import 'package:dariwall/core/route/app_routeing.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/style/app_theme_style.dart';
import 'package:dariwall/features/transactions/presentation/provider/transactions_provider.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';
import 'package:dariwall/global_provider/providers/currency_prices_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => CreateWalletProvider(createWalletUsecase: getIt<CreateWalletUsecase>())),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(
            loginWithEmailUseCase: getIt<LoginWithEmailUseCase>(),
            loginWithKeysUseCase: getIt<LoginWithKeysUseCase>(),
            verifyEmailCodeUseCase: getIt<VerifyEmailCodeUseCase>(),
            logoutUseCase: getIt<LogoutUseCase>(),
            checkLoginUseCase: getIt<CheckLoginUseCase>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<MyBalancesProvider>(),
        ),
        ChangeNotifierProvider(create: (_) => getIt<GetUserAccountInfoProvider>()),
        ChangeNotifierProvider(
          create: (context) => getIt<TransactionsProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<CurrencyPricesProvider>(),
        ),
      ],
      // child: DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => MyApp(),
      // ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: const Locale('fa', 'IR'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', 'IR'),
        Locale('en', 'US'),
      ],
      theme: darkTheme,
      routerConfig: AppRouteing.router,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    SnackBarService.init(context);
                  });
                  return child ?? const SizedBox();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
