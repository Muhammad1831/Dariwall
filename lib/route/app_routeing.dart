import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/pages/forget_password/forget_password_page.dart';
import 'package:ostad/pages/home/home_page.dart';
import 'package:ostad/pages/login/login_page.dart';
import 'package:ostad/pages/price_info/price_info_page.dart';
import 'package:ostad/pages/sign_up/sign_up_page.dart';
import 'package:ostad/pages/splash/splash_page.dart';
import 'package:ostad/pages/user_account/user_account_page.dart';
import 'package:ostad/pages/wallet/wallet_page.dart';
import 'package:ostad/pages/scaffold_with_nav_bar.dart';
import 'package:ostad/route/app_route_name.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRouteName.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRouteName.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRouteName.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRouteName.signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: AppRouteName.forgetPassword,
        builder: (context, state) => const ForgetPasswordPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteName.wallet,
                builder: (context, state) => const WalletPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteName.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteName.priceInfo,
                builder: (context, state) => const PriceInfoPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteName.userAccount,
                builder: (context, state) => const UserAccountPage(),
              ),
            ],
          ),
        ],
      )
    ],

    // errorBuilder: (context, state) => ErrorPage(error: state.error),

    // redirect: (context, state) {
    //   final bool isLoggedIn = false;

    //   final isGoingToLogin = state.matchedLocation == AppRouteName.login;
    //   final isGoingToSignUp = state.matchedLocation == AppRouteName.signUp;
    //   final isGoingToForgetPassword = state.matchedLocation == AppRouteName.forgetPassword;

    //   if (!isLoggedIn &&
    //       !isGoingToLogin &&
    //       !isGoingToSignUp &&
    //       !isGoingToForgetPassword &&
    //       state.matchedLocation != AppRouteName.splash) {
    //     return AppRouteName.login;
    //   }

    //   if (isLoggedIn && (isGoingToLogin || isGoingToSignUp)) {
    //     return AppRouteName.home;
    //   }

    //   return null;
    // },
  );
}
