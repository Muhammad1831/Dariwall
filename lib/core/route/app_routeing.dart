import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/route/app_route_path.dart';
import 'package:ostad/features/buy/presentation/page/buy_page.dart';
import 'package:ostad/features/create_wallet/presentation/page/create_wallet_page.dart';
import 'package:ostad/features/forget_password/presentation/page/forget_password_page.dart';
import 'package:ostad/features/home/presentation/page/home_page.dart';
import 'package:ostad/features/invite_friends/presentaion/page/invite_friends_page.dart';
import 'package:ostad/features/learn_and_guide/presentation/page/learn_and_guide_page.dart';
import 'package:ostad/features/login/presentation/page/login_page.dart';
import 'package:ostad/features/login/presentation/provider/auth_provider.dart';
import 'package:ostad/features/missions/presentation/page/missions_page.dart';
import 'package:ostad/features/receive/presentation/page/receive_page.dart';
import 'package:ostad/features/recovery_phrase/presentation/page/recovery_phrase_page.dart';
import 'package:ostad/features/send/presentation/page/send_page.dart';
import 'package:ostad/features/sign_up/presentation/page/sign_up_page.dart';
import 'package:ostad/features/splash/presentation/page/splash_page.dart';
import 'package:ostad/features/swap/presentation/page/swap_page.dart';
import 'package:ostad/features/tasks/presentation/page/follow_x_page.dart';
import 'package:ostad/features/tasks/presentation/page/like_coinmarketcap_page.dart';
import 'package:ostad/features/user_account/presentation/page/user_account_page.dart';
import 'package:ostad/features/transactions/presentation/page/transactions_page.dart';
import 'package:ostad/features/scaffold_with_nav_bar.dart';
import 'package:ostad/core/route/app_route_name.dart';
import 'package:ostad/features/welcome/presentation/page/welcome_page.dart';
import 'package:provider/provider.dart';

class RouteLogger extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('Route pushed: ${route.settings.name}');
    debugPrint('Previous route: ${previousRoute?.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('Route popped: ${route.settings.name}');
    debugPrint('Previous route: ${previousRoute?.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint('Route replaced: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('Route removed: ${route.settings.name}');
    debugPrint('Previous route: ${previousRoute?.settings.name}');
  }
}

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRouteName.splash,
    // debugLogDiagnostics: true,
    restorationScopeId: 'app',
    observers: [
      RouteLogger(),
    ],

    redirect: (context, state) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final isLoggedIn = authProvider.isAuthenticated;

      final isPublicRoute = state.matchedLocation == AppRouteName.login ||
          state.matchedLocation == AppRouteName.createWallet ||
          state.matchedLocation == AppRouteName.recoveryphrase ||
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
              state.matchedLocation == AppRouteName.createWallet ||
              state.matchedLocation == AppRouteName.recoveryphrase ||
              state.matchedLocation == AppRouteName.forgetPassword)) {
        return AppRouteName.home;
      }

      return null;
    },

    routes: [
      GoRoute(
        name: AppRouteName.splash,
        path: AppRoutePath.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: AppRouteName.login,
        path: AppRoutePath.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: AppRouteName.signUp,
        path: AppRoutePath.signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        name: AppRouteName.forgetPassword,
        path: AppRoutePath.forgetPassword,
        builder: (context, state) => const ForgetPasswordPage(),
      ),
      GoRoute(
        name: AppRouteName.learnAndGuide,
        path: AppRoutePath.learnAndGuide,
        builder: (context, state) => const LearnAndGuidePage(),
      ),
      GoRoute(
        name: AppRouteName.followX,
        path: AppRoutePath.followX,
        builder: (context, state) => const FollowXPage(),
      ),
      GoRoute(
        name: AppRouteName.likeCoinmarketcap,
        path: AppRoutePath.likeCoinmarketcap,
        builder: (context, state) => const LikeCoinmarketcapPage(),
      ),
      GoRoute(
        name: AppRouteName.welcome,
        path: AppRoutePath.welcome,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        name: AppRouteName.createWallet,
        path: AppRoutePath.createWallet,
        builder: (context, state) => const CreateWalletPage(),
      ),
      GoRoute(
        name: AppRouteName.recoveryphrase,
        path: AppRoutePath.recoveryphrase,
        builder: (context, state) => const RecoveryPhrasePage(),
      ),
      GoRoute(
        name: AppRouteName.buy,
        path: AppRoutePath.buy,
        builder: (context, state) => BuyPage(),
      ),
      GoRoute(
        name: AppRouteName.swap,
        path: AppRoutePath.swap,
        builder: (context, state) => const SwapPage(),
      ),
      GoRoute(
        name: AppRouteName.send,
        path: AppRoutePath.send,
        builder: (context, state) => SendPage(),
      ),
      GoRoute(
        name: AppRouteName.receive,
        path: AppRoutePath.receive,
        builder: (context, state) => const ReceivePage(),
      ),
      GoRoute(
        name: AppRouteName.inviteFriends,
        path: AppRoutePath.inviteFriends,
        builder: (context, state) => const InviteFriendsPage(),
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
                name: AppRouteName.home,
                path: AppRoutePath.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteName.transactions,
                path: AppRoutePath.transactions,
                builder: (context, state) => const TransactionsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteName.missions,
                path: AppRoutePath.missions,
                builder: (context, state) => const MissionsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteName.userAccount,
                path: AppRoutePath.userAccount,
                builder: (context, state) => const UserAccountPage(),
              ),
            ],
          ),
        ],
      )
    ],

    //TODO: must be design
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('صفحه مورد نظر یافت نشد'),
      ),
    ),
  );
}
