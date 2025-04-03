import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/features/login/presentation/provider/auth_provider.dart';
import 'package:ostad/core/route/app_route_name.dart';
import 'package:ostad/core/style/app_text_style.dart';
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
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.checkAuthStatus();
        if (authProvider.isAuthenticated) {
          context.go(AppRouteName.home);
        } else {
          context.go(AppRouteName.login);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 350.r,
            height: 350.r,
            child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColor.splashGradient,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppDimens.medium,
                  children: [
                    Image.asset(
                      AppImages.logo,
                      width: 120.r,
                      height: 120.r,
                    ),
                    Text(
                      AppString.dariWall,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: AppTextStyle.timesNewRoman,
                          ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
