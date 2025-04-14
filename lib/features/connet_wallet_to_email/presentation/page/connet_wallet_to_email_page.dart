import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/route/app_route_name.dart';
import 'package:ostad/core/widgets/app_button.dart';
import 'package:ostad/core/widgets/app_glow_dot.dart';
import 'package:ostad/core/widgets/app_header.dart';
import 'package:ostad/core/widgets/app_text_field.dart';

class ConnetWalletToEmailPage extends StatelessWidget {
  const ConnetWalletToEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.all(AppDimens.paddingLarge),
          child: Stack(
            children: [
              AppGlowDot(
                shadow: AppColor.blueGlowShadow,
              ),
              AppGlowDot(
                bottom: 0,
                left: 0,
                shadow: AppColor.pinkGlowShadow,
              ),
              Center(
                child: Column(
                  children: [
                    AppHeader(
                      headerText: AppString.connectWalletToEmail,
                    ),
                    AppDimens.vSpaceExtraLarge,
                    SvgPicture.asset(
                      AppImages.connectWalletToEmail,
                      fit: BoxFit.scaleDown,
                    ),
                    AppDimens.vSpaceLarge,
                    AppTextFormField.withTitle(
                      title: AppString.email,
                      controller: TextEditingController(),
                      hintText: AppString.enterEmail,
                    ),
                    Spacer(),
                    AppButton(
                      text: AppString.sendCode,
                      onTap: () {
                        context.pushNamed(AppRouteName.validation);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
