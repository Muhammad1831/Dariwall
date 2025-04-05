import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
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
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        if (authProvider.isAuthenticated) {
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
        body: Center(
          child: SizedBox(
            width: 350,
            height: 350,
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
                      width: 120,
                      height: 120,
                    ),
                    Text(
                      AppString.dariWall,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.bold,
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
