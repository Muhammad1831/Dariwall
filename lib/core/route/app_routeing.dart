import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/features/create_wallet/presentation/page/create_wallet_page.dart';
import 'package:ostad/features/forget_password/presentation/page/forget_password_page.dart';
import 'package:ostad/features/home/presentation/page/home_page.dart';
import 'package:ostad/features/learn_and_guide/presentation/page/learn_and_guide_page.dart';
import 'package:ostad/features/login/presentation/page/login_page.dart';
import 'package:ostad/features/missions/presentation/page/missions_page.dart';
import 'package:ostad/features/recovery_phrase/presentation/page/recovery_phrase_page.dart';
import 'package:ostad/features/sign_up/presentation/page/sign_up_page.dart';
import 'package:ostad/features/splash/presentation/page/splash_page.dart';
import 'package:ostad/features/tasks/presentation/page/follow_x_page.dart';
import 'package:ostad/features/tasks/presentation/page/like_coinmarketcap_page.dart';
import 'package:ostad/features/user_account/presentation/page/user_account_page.dart';
import 'package:ostad/features/transactions/presentation/page/transactions_page.dart';
import 'package:ostad/features/scaffold_with_nav_bar.dart';
import 'package:ostad/core/route/app_route_name.dart';
import 'package:ostad/features/welcome/presentation/page/welcome_page.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRouteName.splash,
    debugLogDiagnostics: true,

    // redirect: (context, state) {
    //   final authProvider = Provider.of<AuthProvider>(context, listen: false);
    //   final isLoggedIn = authProvider.isAuthenticated;

    //   final isPublicRoute = state.matchedLocation == AppRouteName.login ||
    //       state.matchedLocation == AppRouteName.createWallet ||
    //       state.matchedLocation == AppRouteName.recoveryphrase ||
    //       state.matchedLocation == AppRouteName.forgetPassword ||
    //       state.matchedLocation == AppRouteName.splash;

    //   if (state.matchedLocation == AppRouteName.splash) {
    //     return null;
    //   }

    //   if (!isLoggedIn && !isPublicRoute) {
    //     return AppRouteName.login;
    //   }

    //   if (isLoggedIn &&
    //       (state.matchedLocation == AppRouteName.login ||
    //           state.matchedLocation == AppRouteName.createWallet ||
    //           state.matchedLocation == AppRouteName.recoveryphrase ||
    //           state.matchedLocation == AppRouteName.forgetPassword)) {
    //     return AppRouteName.home;
    //   }

    //   return null;
    // },

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
      GoRoute(
        path: AppRouteName.followX,
        builder: (context, state) => const FollowXPage(),
      ),
      GoRoute(
        path: AppRouteName.likeCoinmarketcap,
        builder: (context, state) => const LikeCoinmarketcapPage(),
      ),
      GoRoute(
        path: AppRouteName.welcomePage,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: AppRouteName.createWallet,
        builder: (context, state) => const CreateWalletPage(),
      ),
      GoRoute(
        path: AppRouteName.recoveryphrase,
        builder: (context, state) => const RecoveryPhrasePage(),
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
                path: AppRouteName.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteName.wallet,
                builder: (context, state) => const TransactionsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteName.priceInfo,
                builder: (context, state) => const MissionsPage(),
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
