import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
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

class SummaryPage extends StatelessWidget {
  SummaryPage({
    super.key,
  });
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
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

                    return ListView.builder(
                      itemCount: myBalances?.balances?.length ?? 0,
                      itemBuilder: (context, index) {
                        final solanaWalletAddress = Provider.of<GetUserAccountInfoProvider>(context)
                            .userAccountInfo
                            ?.solanaWalletAddress;

                        if (myBalances?.balances?[index].amount == 0) {
                          return SizedBox.shrink();
                        }

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
                                context.pushNamed(AppRouteName.send,
                                    extra: myBalances?.balances?[index]);
                              }
                            },
                            tokenIcon: myBalances?.balances?[index].currencyInfo.currencyIcon ??
                                AppIcons.solana,
                            tokenName:
                                myBalances?.balances?[index].currencyInfo.currencyFaName ?? '',
                            tokenTotalNumber:
                                '${myBalances?.balances?[index].amount.toStringAsFixed(0).threeDigitsThree()} ${myBalances?.balances?[index].currencyInfo.currencyEnName}',
                            tokenTotalPrice:
                                '${myBalances?.balances?[index].valueIrt.toStringAsFixed(0).threeDigitsThree() ?? '0'} ${AppString.toman}',
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
    );
  }
}
