import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/extensions/to_short_wallet_address_extensions.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_text_field.dart';
import 'package:dariwall/features/home/domain/entity/balances_entity.dart';
import 'package:dariwall/features/send/presentation/provider/withdraw_provider.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';
import 'package:dariwall/features/send/presentation/provider/send_provider.dart';
import 'package:dariwall/global_provider/providers/currency_prices_provider.dart';
import 'package:provider/provider.dart';

class SendPage extends StatefulWidget {
  const SendPage({super.key, required this.balance});
  final BalancesEntity balance;

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  final tokenAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CurrencyPricesProvider>(context, listen: false);
    provider.getCurrencyPrice(widget.balance.currencyInfo.currencyCode);
  }

  @override
  void dispose() {
    tokenAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyProvider = Provider.of<CurrencyPricesProvider>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SendProvider(
            currencyPricesProvider: currencyProvider,
            balance: widget.balance,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<WithdrawProvider>(),
        ),
      ],
      child: Consumer<SendProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              body: AppShadowBackground(
                child: Padding(
                  padding: EdgeInsets.all(AppDimens.paddingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppHeader(
                        headerText: '${AppString.send} ${widget.balance.currencyInfo.currencyEnName}',
                      ),
                      AppDimens.vSpaceLarge,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppString.sendTo,
                            style: theme.textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            Provider.of<GetUserAccountInfoProvider>(context)
                                    .userAccountInfo
                                    ?.solanaWalletAddress
                                    ?.toShortWalletAddress() ??
                                '',
                            style: theme.textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      AppDimens.vSpaceVerySmall,
                      Divider(
                        color: theme.disabledColor,
                      ),
                      AppDimens.vSpaceLarge,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (provider.balance.currencyInfo.currencyCode != 'USDT')
                                  SwitchCurrencyIcon(
                                    onTap: () {
                                      provider.switchMode();
                                      tokenAmountController.text = provider.isTokenMode
                                          ? provider.tokenAmount.toString()
                                          : provider.dollarAmount.toString();
                                      if (provider.isTokenMode) {
                                        provider.tokenToUsdt(tokenAmountController.text);
                                      } else {
                                        provider.usdtToToken(tokenAmountController.text);
                                      }
                                    },
                                  ),
                                AppDimens.hSpaceLarge,
                                Text(
                                  provider.isTokenMode
                                      ? widget.balance.currencyInfo.currencyEnName
                                      : AppString.usdt,
                                  style: theme.textTheme.displaySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                AppDimens.hSpaceMedium,
                                Expanded(
                                  child: AppTextFormField(
                                    controller: tokenAmountController,
                                    isDense: true,
                                    hintText: '0',
                                    hintStyle: theme.textTheme.displayLarge,
                                    style: theme.textTheme.displayLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    maxLength: 25,
                                    fill: false,
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      if (provider.isTokenMode) {
                                        provider.tokenToUsdt(value);
                                      } else {
                                        provider.usdtToToken(value);
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            AppDimens.vSpaceMedium,
                            if (provider.balance.currencyInfo.currencyCode != 'USDT')
                              Text(
                                provider.isTokenMode
                                    ? '${AppString.usdt} ${provider.dollarAmount ?? 0}'
                                    : '${widget.balance.currencyInfo.currencyEnName} ${provider.tokenAmount ?? 0}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ],
                        ),
                      ),
                      Divider(
                        color: theme.disabledColor,
                      ),
                      AppDimens.vSpaceVerySmall,
                      Text(
                        '${AppString.availableBalance}:',
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
                      ),
                      AppDimens.vSpaceVerySmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.balance.amount} ${widget.balance.currencyInfo.currencyEnName}',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AppButton(
                            text: AppString.max,
                            bgColor: theme.cardColor,
                            borderRadius: AppDimens.borderRadiusVeryLarge,
                            textHorizontalPadding: AppDimens.paddingLarge,
                            onTap: () {
                              provider.setMaxAmount();
                              tokenAmountController.text = provider.isTokenMode
                                  ? provider.tokenAmount.toString()
                                  : provider.dollarAmount.toString();
                            },
                          ),
                        ],
                      ),
                      AppDimens.vSpaceMedium,
                      Selector<WithdrawProvider, WithdrawStatus>(
                        selector: (context, provider) => provider.status,
                        builder: (context, status, child) {
                          final tokenAmount = double.tryParse(tokenAmountController.text) ?? 0;
                
                          if (status == WithdrawStatus.success) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              context.goNamed(AppRouteName.home);
                            });
                          }
                          return AppButton(
                            isLoading: status == WithdrawStatus.loading,
                            text: AppString.continueText,
                            onTap: () {
                              if (tokenAmount > 0) {
                                context.read<WithdrawProvider>().withdraw(
                                      tokenAmount,
                                      widget.balance.currencyInfo.currencyCode,
                                    );
                              } else {
                                SnackBarService.show(
                                  status: SnackBarStatus.error,
                                  message: AppMessage.amountMustBeGreaterThanZero,
                                );
                              }
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SwitchCurrencyIcon extends StatelessWidget {
  const SwitchCurrencyIcon({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusExtraLarge),
      ),
      color: theme.cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusExtraLarge),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(AppDimens.paddingSmall),
          child: Icon(
            CupertinoIcons.arrow_up_arrow_down,
            color: theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
