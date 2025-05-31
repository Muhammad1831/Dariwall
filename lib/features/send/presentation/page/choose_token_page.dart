import 'package:dariwall/core/enum/type_of_send_enum.dart';
import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/extensions/number_formatter_extension.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_loading.dart';
import 'package:dariwall/core/widgets/app_token_item.dart';
import 'package:dariwall/features/home/presentation/provider/my_balances_provider.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';
import 'package:provider/provider.dart';

class ChooseTokenPage extends StatelessWidget {
  ChooseTokenPage({
    super.key,
    required this.typeOfSend,
  });
  final TextEditingController search = TextEditingController();
  final TypeOfSendEnum typeOfSend;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: AppShadowBackground(
          child: Padding(
            padding: EdgeInsets.all(AppDimens.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeader(headerText: AppString.send),
                AppDimens.vSpaceLarge,
                Text(
                  AppString.chooseToken,
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppDimens.vSpaceSmall,
                Expanded(
                  child: Selector<MyBalancesProvider, MyBalancesStatus>(
                    selector: (context, provider) => provider.status,
                    builder: (context, myBalancesStatus, child) {
                      final myBalances = context.read<MyBalancesProvider>().myBalances;

                      if (myBalancesStatus == MyBalancesStatus.loading) {
                        return AppLoading();
                      }

                      final nonZeroBalances =
                          myBalances?.balances?.where((balance) => balance.amount > 0).toList() ??
                              [];

                      if (nonZeroBalances.isEmpty) {
                        return Center(
                          child: Image.asset(
                            AppImages.noBalanceToSend,
                            fit: BoxFit.scaleDown,
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: nonZeroBalances.length,
                        itemBuilder: (context, index) {
                          final solanaWalletAddress =
                              Provider.of<GetUserAccountInfoProvider>(context)
                                  .userAccountInfo
                                  ?.solanaWalletAddress;

                          return Padding(
                            padding: EdgeInsets.only(bottom: AppDimens.small),
                            child: AppTokenItem(
                              onTap: () {
                                if (solanaWalletAddress == null) {
                                  SnackBarService.show(
                                    status: SnackBarStatus.error,
                                    message: AppMessage.solanaWalletAddressIsNotSet,
                                  );
                                } else {
                                  context.pushNamed(AppRouteName.sendTo, extra: {
                                    'balance': nonZeroBalances[index],
                                    'typeOfSend': typeOfSend,
                                  });
                                }
                              },
                              tokenIcon: nonZeroBalances[index].currencyInfo.currencyIcon ??
                                  AppIcons.solana,
                              tokenName: nonZeroBalances[index].currencyInfo.currencyFaName,
                              tokenTotalNumber:
                                  '${nonZeroBalances[index].amount.toString().threeDigitsThree()} ${nonZeroBalances[index].currencyInfo.currencyEnName}',
                              tokenTotalPrice:
                                  '${nonZeroBalances[index].valueIrt.toStringAsFixed(0).threeDigitsThree()} ${AppString.toman}',
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
