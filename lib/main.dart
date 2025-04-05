import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ostad/features/create_wallet/domain/usecase/create_wallet_usecase.dart';
import 'package:ostad/features/create_wallet/presentation/provider/create_wallet_provider.dart';
import 'package:ostad/features/login/presentation/provider/auth_provider.dart';
import 'package:ostad/core/route/app_routeing.dart';
import 'package:ostad/features/login/data/datasource/auth_service.dart';
import 'package:ostad/core/di/locator_service.dart';
import 'package:ostad/core/style/app_theme_style.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(getIt<AuthService>())),
        ChangeNotifierProvider(
            create: (_) => CreateWalletProvider(createWalletUsecase: getIt<CreateWalletUsecase>())),
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
      ],
      theme: darkTheme,
      // builder: (context, child) {
      //   return MediaQuery(
      //     data: MediaQuery.of(context).copyWith(
      //       textScaler: const TextScaler.linear(1.0),
      //     ),
      //     child: child!,
      //   );
      // },
      routerConfig: AppRouter.router,
    );
  }
}
