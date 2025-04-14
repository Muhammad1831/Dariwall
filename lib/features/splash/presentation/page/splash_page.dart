import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/widgets/app_gradiant_text.dart';
import 'package:ostad/core/widgets/app_glow_dot.dart';
import 'package:ostad/features/login/presentation/provider/auth_provider.dart';
import 'package:ostad/core/route/app_route_name.dart';
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
        // final authProvider = Provider.of<AuthProvider>(context, listen: false);
        // if (authProvider.isAuthenticated) {
        context.goNamed(AppRouteName.home);
        // } else {
        // context.goNamed(AppRouteName.welcome);
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(bottom: AppDimens.paddingMedium),
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // blue shadow
                AppGlowDot(
                  top: 25,
                  right: -100,
                  shadow: AppColor.blueGlowShadow,
                ),
                // pink shadow
                AppGlowDot(
                  bottom: -25,
                  left: -100,
                  shadow: AppColor.pinkGlowShadow,
                ),
                // persion dariwall and logo
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.logo,
                      fit: BoxFit.contain,
                    ),
                    AppGradiantText(
                      AppString.dariWall,
                      gradient: AppColor.logoGradient,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                // english dariwall
                Positioned(
                  bottom: 0,
                  child: AppGradiantText(
                    AppString.dariWallEnglish,
                    gradient: AppColor.logoEnglishGradient,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
