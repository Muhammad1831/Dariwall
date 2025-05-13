import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_text_field.dart';
import 'package:dariwall/core/widgets/app_token_item.dart';

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
          child: Column(
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
              Text(AppString.chooseToken),
              AppDimens.vSpaceSmall,
              Expanded(
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) => AppTokenItem(
                      tokenIcon: AppIcons.solana,
                      tokenName: 'Solana',
                      tokenProfit: '100%',
                      tokenTotalNumber: '100',
                      tokenTotalPrice: '100'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
