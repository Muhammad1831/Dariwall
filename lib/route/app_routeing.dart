import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/pages/forget_password/forget_password_page.dart';
import 'package:ostad/pages/home/home_page.dart';
import 'package:ostad/pages/learn_and_guide/learn_and_guide_page.dart';
import 'package:ostad/pages/login/login_page.dart';
import 'package:ostad/pages/price_info/price_info_page.dart';
import 'package:ostad/pages/sign_up/sign_up_page.dart';
import 'package:ostad/pages/splash/splash_page.dart';
import 'package:ostad/pages/user_account/user_account_page.dart';
import 'package:ostad/pages/wallet/wallet_page.dart';
import 'package:ostad/pages/scaffold_with_nav_bar.dart';
import 'package:ostad/route/app_route_name.dart';
import 'package:provider/provider.dart';
import 'package:ostad/providers/auth_provider.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRouteName.splash,
    debugLogDiagnostics: true,

    redirect: (context, state) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final isLoggedIn = authProvider.isAuthenticated;

      final isPublicRoute = state.matchedLocation == AppRouteName.login ||
          state.matchedLocation == AppRouteName.signUp ||
          state.matchedLocation == AppRouteName.forgetPassword ||
          state.matchedLocation == AppRouteName.splash;

      if (state.matchedLocation == AppRouteName.splash) {
        return null;
      }

      if (!isLoggedIn && !isPublicRoute) {
        return AppRouteName.login;
      }

      if (isLoggedIn &&
          (state.matchedLocation == AppRouteName.login ||
              state.matchedLocation == AppRouteName.signUp ||
              state.matchedLocation == AppRouteName.forgetPassword)) {
        return AppRouteName.home;
      }

      return null;
    },

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
      GoRoute(
        path: AppRouteName.learnAndGuide,
        builder: (context, state) => const LearnAndGuidePage(),
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
  );
}
