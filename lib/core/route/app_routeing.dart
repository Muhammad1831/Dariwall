import 'package:dariwall/features/missions/data/model/mission_model.dart';
import 'package:dariwall/features/missions/presentation/page/parax_mission/check_join_parax_telegram_channel_page.dart';
import 'package:dariwall/features/missions/presentation/page/parax_mission/follow_parax_in_twitter_page.dart';
import 'package:dariwall/features/missions/presentation/page/parax_mission/like_parax_in_coinmarketcap_page.dart';
import 'package:dariwall/features/missions/presentation/page/parax_mission/like_parax_twitter_post_page.dart';
import 'package:dariwall/features/missions/presentation/page/parax_mission/retweet_parax_twitter_post_page.dart';
import 'package:dariwall/features/transactions/domain/entity/base_transactions_entity.dart';
import 'package:dariwall/features/transactions/presentation/page/details_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/route/app_route_path.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/about_us/about_us_page.dart';
import 'package:dariwall/features/buy/presentation/page/buy_page.dart';
import 'package:dariwall/features/coming_soon/coming_soon_page.dart';
import 'package:dariwall/features/connet_wallet_to_email/presentation/page/connect_wallet_email_otp.dart';
import 'package:dariwall/features/connet_wallet_to_email/presentation/page/connect_wallet_to_email_page.dart';
import 'package:dariwall/features/gift_code_page/presentation/pages/gift_code_page.dart';
import 'package:dariwall/features/home/domain/entity/balances_entity.dart';
import 'package:dariwall/features/missions/presentation/page/ostad_mission/comment_on_twitter_mission_page.dart';
import 'package:dariwall/features/missions/presentation/page/ostad_mission/join_dariwall_telegram_channel_mission_page.dart';
import 'package:dariwall/features/missions/presentation/page/ostad_mission/join_discussion_group_mission_page.dart';
import 'package:dariwall/features/missions/presentation/page/ostad_mission/join_telegram_channel_mission_page.dart';
import 'package:dariwall/features/missions/presentation/page/ostad_mission/like_twitter_mission_page.dart';
import 'package:dariwall/features/missions/presentation/page/ostad_mission/retweet_twitter_mission_page.dart';
import 'package:dariwall/features/missions/presentation/page/ostad_mission/student_info_missions_page.dart';
import 'package:dariwall/features/send/presentation/page/choose_token_page.dart';
import 'package:dariwall/features/send/presentation/page/summary_page.dart';
import 'package:dariwall/features/solana_address_wallet/presentation/page/solana_address_wallet_page.dart';
import 'package:dariwall/features/user_account_info_edit/presentation/page/user_account_info_edit_page.dart';
import 'package:dariwall/features/validation/presentation/page/validation_page.dart';
import 'package:dariwall/features/create_new_wallet/presentation/page/create_new_wallet_page.dart';
import 'package:dariwall/features/home/presentation/page/home_page.dart';
import 'package:dariwall/features/invite_friends/presentaion/page/invite_friends_page.dart';
import 'package:dariwall/features/learn_and_guide/presentation/page/learn_and_guide_page.dart';
import 'package:dariwall/features/login/presentation/page/login_page.dart';
import 'package:dariwall/features/login/presentation/page/login_with_email_page.dart';
import 'package:dariwall/features/login/presentation/page/login_with_keys_page.dart';
import 'package:dariwall/features/login/presentation/provider/login_provider.dart';
import 'package:dariwall/features/missions/presentation/page/missions_page.dart';
import 'package:dariwall/features/receive/presentation/page/receive_page.dart';
import 'package:dariwall/features/recovery_phrase/presentation/page/recovery_phrase_page.dart';
import 'package:dariwall/features/send/presentation/page/send_page.dart';
import 'package:dariwall/features/splash/presentation/page/splash_page.dart';
import 'package:dariwall/features/swap/presentation/page/swap_page.dart';
import 'package:dariwall/features/missions/presentation/page/ostad_mission/follow_twitter_mission_page.dart';
import 'package:dariwall/features/missions/presentation/page/ostad_mission/like_coinmarketcap_mission_page.dart';
import 'package:dariwall/features/user_account/presentation/page/user_account_page.dart';
import 'package:dariwall/features/transactions/presentation/page/transactions_page.dart';
import 'package:dariwall/features/scaffold_with_nav_bar.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/features/welcome/presentation/page/welcome_page.dart';
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

class AppRouteing {
  static final GoRouter router = GoRouter(
    initialLocation: AppRouteName.splash,
    navigatorKey: SnackBarService.navigatorKey,
    routerNeglect: true,

    // debugLogDiagnostics: true,
    restorationScopeId: 'app',
    observers: [
      RouteLogger(),
    ],

    redirect: (context, state) {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final isLoggedIn = loginProvider.isLoggedIn;
      final currentPath = state.matchedLocation;

      // List of public routes that don't require authentication
      final publicRoutes = [
        AppRouteName.splash,
        AppRouteName.login,
        AppRouteName.welcome,
        AppRouteName.createNewWallet,
      ];

      // If on splash screen, let it proceed
      if (currentPath == AppRouteName.splash) return null;

      // If not logged in and trying to access public route, redirect to it
      if (!isLoggedIn && !publicRoutes.contains(currentPath)) {
        return currentPath;
      }

      // If logged in and trying to access login page, redirect to home
      if (isLoggedIn && currentPath == AppRouteName.login) {
        return AppRouteName.home;
      }

      return null;
    },

    routes: [
      // splash
      GoRoute(
        name: AppRouteName.splash,
        path: AppRoutePath.splash,
        builder: (context, state) => const SplashPage(),
      ),

      // welcome
      GoRoute(
        name: AppRouteName.welcome,
        path: AppRoutePath.welcome,
        builder: (context, state) => const WelcomePage(),
        routes: [
          // login
          GoRoute(
            name: AppRouteName.login,
            path: AppRoutePath.login,
            builder: (context, state) => const LoginPage(),
            routes: [
              GoRoute(
                name: AppRouteName.loginWithEmail,
                path: AppRoutePath.loginWithEmail,
                builder: (context, state) => const LoginWithEmailPage(),
              ),
              GoRoute(
                name: AppRouteName.validation,
                path: AppRoutePath.validation,
                builder: (context, state) => ValidationPage(
                  email: state.extra as String,
                ),
              ),
              GoRoute(
                name: AppRouteName.loginWithKeys,
                path: AppRoutePath.loginWithKeys,
                builder: (context, state) => LoginWithKeysPage(),
              ),
            ],
          ),

          // create new wallet
          GoRoute(
            name: AppRouteName.createNewWallet,
            path: AppRoutePath.createNewWallet,
            builder: (context, state) => const CreateNewWalletPage(),
            routes: [
              GoRoute(
                name: AppRouteName.recoveryphrase,
                path: AppRoutePath.recoveryphrase,
                builder: (context, state) => const RecoveryPhrasePage(),
              ),
              GoRoute(
                name: AppRouteName.connectWalletToEmail,
                path: AppRoutePath.connectWalletToEmail,
                builder: (context, state) => const ConnetWalletToEmailPage(),
              ),
              GoRoute(
                name: AppRouteName.connectWalletEmailOtp,
                path: AppRoutePath.connectWalletEmailOtp,
                builder: (context, state) => ConnectWalletEmailOtpPage(
                  email: state.extra as String,
                ),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        name: AppRouteName.userAccountInfoEdit,
        path: AppRoutePath.userAccountInfoEdit,
        builder: (context, state) => UserAccountInfoEditPage(),
      ),
      GoRoute(
        name: AppRouteName.solanaAddressWallet,
        path: AppRoutePath.solanaAddressWallet,
        builder: (context, state) => SolanaAddressWalletPage(),
      ),
      GoRoute(
        name: AppRouteName.comingSoon,
        path: AppRoutePath.comingSoon,
        builder: (context, state) => const ComingSoonPage(),
      ),
      GoRoute(
        name: AppRouteName.aboutUs,
        path: AppRoutePath.aboutUs,
        builder: (context, state) => const AboutUsPage(),
      ),
      GoRoute(
        name: AppRouteName.giftCode,
        path: AppRoutePath.giftCode,
        builder: (context, state) => const GiftCodePage(),
      ),
      GoRoute(
        name: AppRouteName.learnAndGuide,
        path: AppRoutePath.learnAndGuide,
        builder: (context, state) => const LearnAndGuidePage(),
      ),
      GoRoute(
        name: AppRouteName.commentOnTwitterMission,
        path: AppRoutePath.commentOnTwitterMission,
        builder: (context, state) => CommentOnTwitterMissionPage(
          mission: state.extra as MissionModel,
        ),
      ),
      GoRoute(
        name: AppRouteName.joinTelegramChannelMission,
        path: AppRoutePath.joinTelegramChannelMission,
        builder: (context, state) => JoinTelegramChannelMissionPage(
          mission: state.extra as MissionModel,
        ),
      ),
      GoRoute(
        name: AppRouteName.joinDiscussionGroupMission,
        path: AppRoutePath.joinDiscussionGroupMission,
        builder: (context, state) => JoinDiscussionGroupMissionPage(
          mission: state.extra as MissionModel,
        ),
      ),
      GoRoute(
        name: AppRouteName.retweetTwitterMission,
        path: AppRoutePath.retweetTwitterMission,
        builder: (context, state) => RetweetTwitterMissionPage(
          mission: state.extra as MissionModel,
        ),
      ),
      GoRoute(
        name: AppRouteName.followTwitterMission,
        path: AppRoutePath.followTwitterMission,
        builder: (context, state) => FollowTwitterMissionPage(
          mission: state.extra as MissionModel,
        ),
      ),
      GoRoute(
        name: AppRouteName.likeTwitterMission,
        path: AppRoutePath.likeTwitterMission,
        builder: (context, state) => LikeTwitterMissionPage(
          mission: state.extra as MissionModel,
        ),
      ),
      GoRoute(
        name: AppRouteName.studentInfoMissions,
        path: AppRoutePath.studentInfoMissions,
        builder: (context, state) => StudentInfoMissionsPage(
          mission: state.extra as MissionModel,
        ),
      ),
      GoRoute(
        name: AppRouteName.likeCoinmarketcapMission,
        path: AppRoutePath.likeCoinmarketcapMission,
        builder: (context, state) => LikeCoinmarketcapMissionPage(
          mission: state.extra as MissionModel,
        ),
      ),
      GoRoute(
        name: AppRouteName.joinDariwallTelegramChannelMission,
        path: AppRoutePath.joinDariwallTelegramChannelMission,
        builder: (context, state) => JoinDariwallTelegramChannelMissionPage(
          mission: state.extra as MissionModel,
        ),
      ),
      // parax mission
      GoRoute(
        name: AppRouteName.likeParaxInCoinmarketcap,
        path: AppRoutePath.likeParaxInCoinmarketcap,
        builder: (context, state) => LikeParaxInCoinmarketcapPage(
          mission: state.extra as MissionModel,
        ),
      ),
      GoRoute(
        name: AppRouteName.likeParaxTwitterPost,
        path: AppRoutePath.likeParaxTwitterPost,
        builder: (context, state) => LikeParaxTwitterPostPage(
          mission: state.extra as MissionModel,
        ),
      ),
      GoRoute(
        name: AppRouteName.followParaxInTwitter,
        path: AppRoutePath.followParaxInTwitter,
        builder: (context, state) => FollowParaxInTwitterPage(
          mission: state.extra as MissionModel,
        ),
      ),
      GoRoute(
        name: AppRouteName.retweetParaxTwitterPost,
        path: AppRoutePath.retweetParaxTwitterPost,
        builder: (context, state) => RetweetParaxTwitterPostPage(
          mission: state.extra as MissionModel,
        ),
      ),
      GoRoute(
        name: AppRouteName.checkJoinParaxTelegramChannel,
        path: AppRoutePath.checkJoinParaxTelegramChannel,
        builder: (context, state) => CheckJoinParaxTelegramChannelPage(
          mission: state.extra as MissionModel,
        ),
      ),
      GoRoute(
        name: AppRouteName.commentOnParaxTwitterPost,
        path: AppRoutePath.commentOnParaxTwitterPost,
        builder: (context, state) => CommentOnTwitterMissionPage(
          mission: state.extra as MissionModel,
        ),
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
        builder: (context, state) => SendPage(
          balance: state.extra as BalancesEntity,
        ),
      ),
      GoRoute(
        name: AppRouteName.chooseToken,
        path: AppRoutePath.chooseToken,
        builder: (context, state) => ChooseTokenPage(),
      ),
      GoRoute(
        name: AppRouteName.summary,
        path: AppRoutePath.summary,
        builder: (context, state) => SummaryPage(),
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
      GoRoute(
        name: AppRouteName.detailsTransaction,
        path: AppRoutePath.detailsTransaction,
        builder: (context, state) => DetailsTransactionPage(
          transaction: state.extra as BaseTransactionEntity,
        ),
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
