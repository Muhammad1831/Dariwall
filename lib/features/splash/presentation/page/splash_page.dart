import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/features/login/presentation/provider/login_provider.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () async {
        final loginProvider = Provider.of<LoginProvider>(context, listen: false);
        if (loginProvider.isLoggedIn) {
          // Get user account info if user is already logged in
          await GetIt.I<GetUserAccountInfoProvider>().getUserAccountInfo();
          context.goNamed(AppRouteName.home);
        } else {
          context.goNamed(AppRouteName.welcome);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AppShadowBackground(
          bottomGlowDot: 0,
          child: Padding(
            padding: EdgeInsets.only(bottom: AppDimens.paddingMedium),
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // blue shadow
                  // AppGlowDot(
                  //   top: 25,
                  //   right: -100,
                  //   shadow: AppColor.blueGlowShadow,
                  // ),
                  // pink shadow
                  // AppGlowDot(
                  //   bottom: -25,
                  //   left: -100,
                  //   shadow: AppColor.pinkGlowShadow,
                  // ),
                  // persion dariwall and logo
                  Image.asset(
                    AppImages.logo,
                    fit: BoxFit.contain,
                    height: 150,
                    width: 200,
                  ),
                  // english dariwall
                  // Positioned(
                  //   bottom: 0,
                  //   child: AppGradiantText(
                  //     AppString.dariWallEnglish,
                  //     gradient: AppColor.logoEnglishGradient,
                  //     style: Theme.of(context).textTheme.bodyLarge,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
