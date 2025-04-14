import 'package:flutter/material.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/widgets/app_glow_dot.dart';
import 'package:ostad/core/widgets/app_header.dart';
import 'package:ostad/core/widgets/app_text_field.dart';
import 'package:ostad/core/widgets/app_token_item.dart';

class BuyPage extends StatelessWidget {
  BuyPage({super.key});
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppDimens.paddingLarge,
            horizontal: AppDimens.paddingMedium,
          ),
          child: Stack(
            children: [
              AppGlowDot(shadow: AppColor.blueGlowShadow),
              AppGlowDot(
                shadow: AppColor.pinkGlowShadow,
                bottom: 0,
                left: 0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeader(headerText: AppString.buy),
                  AppDimens.vSpaceLarge,
                  AppTextFormField(
                    controller: search,
                    hintText: AppString.search,
                    suffixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                  AppDimens.vSpaceLarge,
                  Text(AppString.popularTokens),
                  AppDimens.vSpaceSmall,
                  Expanded(
                    child: ListView.builder(
                      itemCount: 12,
                      itemBuilder: (context, index) => AppTokenCard(
                          tokenIcon: AppIcons.solana,
                          tokenName: 'Solana',
                          tokenProfit: '100%',
                          tokenTotalNumber: '100',
                          tokenTotalPrice: '100'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
