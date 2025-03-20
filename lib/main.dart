import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ostad/pages/forget_password/forget_password_page.dart';
import 'package:ostad/pages/login/login_page.dart';
import 'package:ostad/pages/sign_up/sign_up_page.dart';
import 'package:ostad/pages/splash/splash_page.dart';
import 'package:ostad/providers/auth_provider.dart';
import 'package:ostad/route/app_routeing.dart';
import 'package:ostad/services/api_client.dart';
import 'package:ostad/services/auth_service.dart';
import 'package:ostad/style/app_theme.dart';
import 'package:ostad/utils/app_shared_preferences.dart';
import 'package:ostad/widgets/app_snack_bar.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();

  final appPreferences = AppSharedPreferences.getInstance;
  final apiClient = ApiClient(appPreferences);
  final authService = AuthService(apiClient, appPreferences);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authService)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
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
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
