import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/enum/payment_direction_enum.dart';
import 'package:dariwall/core/enum/transactions_type_enum.dart';
import 'package:dariwall/core/extensions/decimal_format_extension.dart';
import 'package:dariwall/core/extensions/index_plus_one_extension.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/widgets/app_loading.dart';
import 'package:dariwall/core/widgets/app_text_field.dart';
import 'package:dariwall/core/widgets/app_token_item.dart';
import 'package:dariwall/features/home/domain/entity/balances_entity.dart';
import 'package:dariwall/features/home/presentation/provider/my_balances_provider.dart';
import 'package:dariwall/features/swap/data/model/swap_param_model.dart';
import 'package:dariwall/features/swap/presentation/provider/swap_provider.dart';
import 'package:dariwall/global_provider/data/model/calculate_fee_model.dart';
import 'package:dariwall/global_provider/data/model/calculate_source_target_value_model.dart';
import 'package:dariwall/global_provider/providers/calculate_fee_provider.dart';
import 'package:dariwall/global_provider/providers/calculate_source_target_value_provider.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SwapPage extends StatefulWidget {
  const SwapPage({super.key});

  @override
  State<SwapPage> createState() => _SwapPageState();
}

class _SwapPageState extends State<SwapPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt<SwapProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<CalculateFeeProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<CalculateSourceTargetValueProvider>(),
        ),
      ],
      child: Consumer2<SwapProvider, CalculateSourceTargetValueProvider>(
        builder: (context, swapProvider, calculateSourceTargetValueProvider, child) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimens.paddingLarge,
                  horizontal: AppDimens.paddingMedium,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppHeader(headerText: AppString.swapToken),
                    AppDimens.vSpaceMedium,
                    // you payed
                    SwapCard(
                      onEditingComplete: () async {
                        if (swapProvider.fromToken != null && swapProvider.toToken != null) {
                          await calculateSourceTargetValueProvider.calculateSourceTargetValue(
                            param: CalculateSourceTargetValueParameterModel(
                              sourceAmount: double.tryParse(swapProvider.fromController.text) ?? 0,
                              sourceCurrencyCode: swapProvider.fromToken!.currencyInfo.currencyCode,
                              targetCurrencyCode: swapProvider.toToken!.currencyInfo.currencyCode,
                            ),
                          );
                          if (calculateSourceTargetValueProvider.calculateSourceTargetValueModel !=
                              null) {
                            swapProvider.toController.text = calculateSourceTargetValueProvider
                                .calculateSourceTargetValueModel!.targetAmount
                                .toString();
                          }
                          await Provider.of<CalculateFeeProvider>(context, listen: false)
                              .calculateFee(
                            param: CalculateFeeParamModel(
                              amount: double.tryParse(swapProvider.fromController.text) ?? 0,
                              currencyCode: swapProvider.fromToken!.currencyInfo.currencyCode,
                              transactionType: '${TransactionsTypeEnum.swap.indexPlusOne}',
                            ),
                          );
                        }
                      },
                      onChange: (value) async {},
                      controller: swapProvider.fromController,
                      paymentDirection: PaymentDirectionEnum.pay,
                      balancesEntity: swapProvider.fromToken,
                    ),
                    AppDimens.vSpaceSmall,
                    // you recived
                    SwapCard(
                      onEditingComplete: () async {
                        if (swapProvider.fromToken != null && swapProvider.toToken != null) {
                          await calculateSourceTargetValueProvider.calculateSourceTargetValue(
                            param: CalculateSourceTargetValueParameterModel(
                              sourceAmount: double.tryParse(swapProvider.toController.text) ?? 0,
                              sourceCurrencyCode: swapProvider.toToken!.currencyInfo.currencyCode,
                              targetCurrencyCode: swapProvider.fromToken!.currencyInfo.currencyCode,
                            ),
                          );
                          if (calculateSourceTargetValueProvider.calculateSourceTargetValueModel !=
                              null) {
                            swapProvider.fromController.text = calculateSourceTargetValueProvider
                                .calculateSourceTargetValueModel!.targetAmount
                                .toString();
                          }
                          await Provider.of<CalculateFeeProvider>(context, listen: false)
                              .calculateFee(
                            param: CalculateFeeParamModel(
                              amount: double.tryParse(swapProvider.fromController.text) ?? 0,
                              currencyCode: swapProvider.fromToken!.currencyInfo.currencyCode,
                              transactionType: '${TransactionsTypeEnum.swap.indexPlusOne}',
                            ),
                          );
                        }
                      },
                      onChange: (value) async {},
                      
                      controller: swapProvider.toController,
                      paymentDirection: PaymentDirectionEnum.recive,
                      balancesEntity: swapProvider.toToken,
                    ),
                    AppDimens.vSpaceSmall,
                    // fee
                    SwapFeeCard(theme: theme),
                    Spacer(),
                    Selector<SwapProvider, SwapStatus>(
                      selector: (p0, swapProvider) => swapProvider.status,
                      builder: (context, value, child) {
                        if (value == SwapStatus.success) {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (_) => context.goNamed(AppRouteName.home),
                          );
                        }
                        return AppButton(
                          isLoading: value == SwapStatus.loading,
                          text: AppString.swap,
                          onTap: () async {
                            if (swapProvider.fromToken != null &&
                                swapProvider.toToken != null &&
                                swapProvider.fromController.text.isNotEmpty) {
                              await swapProvider.swap(
                                param: SwapParamModel(
                                  amount: double.tryParse(swapProvider.fromController.text) ?? 0,
                                  sourceCurrencyCode:
                                      swapProvider.fromToken!.currencyInfo.currencyCode,
                                  targetCurrencyCode:
                                      swapProvider.toToken!.currencyInfo.currencyCode,
                                ),
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
          );
        },
      ),
    );
  }
}

class SwapFeeCard extends StatelessWidget {
  const SwapFeeCard({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(
          AppDimens.borderRadiusMedium,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimens.paddingMedium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppString.swapFee,
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            Selector<CalculateFeeProvider, CalculateFeeStatus>(
              selector: (context, provider) => provider.status,
              builder: (context, value, child) {
                final provider = context.watch<CalculateFeeProvider>();
                if (value == CalculateFeeStatus.loading) {
                  return AppLoading();
                }

                return Text(
                  value == CalculateFeeStatus.success
                      ? '${provider.calculateFeeModel.feeUSDT}' ' ${AppString.usdt}'
                      : '-',
                  style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class SwapCard extends StatelessWidget {
  const SwapCard(
      {super.key,
      required TextEditingController controller,
      required this.paymentDirection,
      required this.balancesEntity,
      required this.onChange,
      required this.onEditingComplete})
      : _controller = controller;

  final TextEditingController _controller;
  final PaymentDirectionEnum paymentDirection;
  final BalancesEntity? balancesEntity;
  final void Function(String) onChange;
  final void Function() onEditingComplete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final swapProvider = context.watch<SwapProvider>();
    final feeProvider = context.watch<CalculateFeeProvider>();

    final calculateSourceTargetValueProvider = context.watch<CalculateSourceTargetValueProvider>();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusMedium),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimens.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              paymentDirection == PaymentDirectionEnum.pay ? AppString.pay : AppString.receive,
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            AppDimens.vSpaceVerySmall,
            Row(
              children: [
                Expanded(
                  child: AppTextFormField(
                    controller: _controller,
                    hintText: AppString.zero,
                    hintStyle: theme.textTheme.displayLarge,
                    fill: false,
                    style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    focusedBorderColor: Colors.transparent,
                    enabledBorderColor: Colors.transparent,
                    onChanged: onChange,
                    onEditingComplete: onEditingComplete,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return MultiProvider(
                              providers: [
                                ChangeNotifierProvider.value(
                                  value: swapProvider,
                                ),
                                ChangeNotifierProvider.value(
                                  value: feeProvider,
                                ),
                                ChangeNotifierProvider.value(
                                  value: calculateSourceTargetValueProvider,
                                ),
                              ],
                              child: CurrenciesModalBottomSheet(
                                paymentDirection: paymentDirection,
                              ),
                            );
                          },
                        );
                      },
                      icon: RotatedBox(
                        quarterTurns: 45,
                        child: Icon(Icons.chevron_left),
                      ),
                    ),
                    if (balancesEntity == null)
                      Text(
                        paymentDirection == PaymentDirectionEnum.pay
                            ? AppString.paymentCurrency
                            : AppString.reciveCurrency,
                      ),
                    if (balancesEntity != null) Text(balancesEntity!.currencyInfo.currencyEnName),
                    AppDimens.hSpaceSmall,
                    if (balancesEntity != null)
                      Image.network(
                        balancesEntity!.currencyInfo.currencyIcon!,
                        fit: BoxFit.contain,
                        height: AppDimens.iconVeryLarge,
                        width: AppDimens.iconVeryLarge,
                      )
                  ],
                ),
              ],
            ),
            if (balancesEntity != null && balancesEntity!.amount != 0)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${balancesEntity!.amount} ${balancesEntity!.currencyInfo.currencyEnName}',
                  style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.onSurface),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class CurrenciesModalBottomSheet extends StatelessWidget {
  const CurrenciesModalBottomSheet({
    super.key,
    required this.paymentDirection,
  });

  final PaymentDirectionEnum paymentDirection;

  @override
  Widget build(BuildContext context) {
    return Selector3<MyBalancesProvider, CalculateFeeProvider, CalculateSourceTargetValueProvider,
        MyBalancesStatus>(
      selector: (context, balanceProvider, feeProvider, calculateSourceTargetValueProvider) =>
          balanceProvider.status,
      builder: (context, myBalancesStatus, child) {
        final myBalances = context.read<MyBalancesProvider>().myBalances;
        final swapProvider = context.watch<SwapProvider>();
        final feeProvider = context.watch<CalculateFeeProvider>();
        final calculateSourceTargetValueProvider =
            context.watch<CalculateSourceTargetValueProvider>();

        if (myBalancesStatus == MyBalancesStatus.loading) {
          return AppLoading();
        }

        final nonZeroBalances = myBalances?.balances
                ?.where(
                  (balance) => paymentDirection == PaymentDirectionEnum.pay
                      ? balance.amount > 0
                      : balance.amount >= 0,
                )
                .toList() ??
            [];

        if (nonZeroBalances.isEmpty) {
          return Center(
            child: Image.asset(
              AppImages.noBalanceToSend,
              fit: BoxFit.scaleDown,
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.all(AppDimens.small),
          child: ListView.builder(
            itemCount: nonZeroBalances.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: AppDimens.small),
                child: AppTokenItem(
                  onTap: () async {
                    if (paymentDirection == PaymentDirectionEnum.pay) {
                      swapProvider.selectedFromToken(nonZeroBalances[index]);
                      if (swapProvider.toToken != null &&
                          swapProvider.fromToken != null &&
                          swapProvider.toController.text.isNotEmpty &&
                          swapProvider.fromController.text.isNotEmpty) {
                        await feeProvider.calculateFee(
                          param: CalculateFeeParamModel(
                              amount: double.tryParse(swapProvider.fromController.text) ?? 0,
                              currencyCode: swapProvider.fromToken!.currencyInfo.currencyCode,
                              transactionType: '${TransactionsTypeEnum.swap.indexPlusOne}'),
                        );
                        await calculateSourceTargetValueProvider.calculateSourceTargetValue(
                          param: CalculateSourceTargetValueParameterModel(
                            sourceAmount: double.tryParse(swapProvider.fromController.text) ?? 0,
                            sourceCurrencyCode: swapProvider.fromToken!.currencyInfo.currencyCode,
                            targetCurrencyCode: swapProvider.toToken!.currencyInfo.currencyCode,
                          ),
                        );
                        if (calculateSourceTargetValueProvider.calculateSourceTargetValueModel !=
                            null) {
                          swapProvider.toController.text = calculateSourceTargetValueProvider
                              .calculateSourceTargetValueModel!.targetAmount
                              .toString();
                        }
                      }
                    } else {
                      swapProvider.selectedToToken(nonZeroBalances[index]);
                      if (swapProvider.fromToken != null &&
                          swapProvider.toToken != null &&
                          swapProvider.fromController.text.isNotEmpty) {
                        await calculateSourceTargetValueProvider.calculateSourceTargetValue(
                          param: CalculateSourceTargetValueParameterModel(
                            sourceAmount: double.tryParse(swapProvider.fromController.text) ?? 0,
                            sourceCurrencyCode: swapProvider.fromToken!.currencyInfo.currencyCode,
                            targetCurrencyCode: swapProvider.toToken!.currencyInfo.currencyCode,
                          ),
                        );
                        if (calculateSourceTargetValueProvider.calculateSourceTargetValueModel !=
                            null) {
                          swapProvider.toController.text = calculateSourceTargetValueProvider
                              .calculateSourceTargetValueModel!.targetAmount
                              .toString();
                        }
                      }
                    }
                    context.pop();
                  },
                  tokenIcon: nonZeroBalances[index].currencyInfo.currencyIcon ?? AppIcons.solana,
                  tokenName: nonZeroBalances[index].currencyInfo.currencyFaName,
                  tokenTotalNumber:
                      '${nonZeroBalances[index].amount.toString().formatDecimal()} ${nonZeroBalances[index].currencyInfo.currencyEnName}',
                  tokenTotalPrice:
                      '${nonZeroBalances[index].valueIrt.toString().formatDecimal()} ${AppString.toman}',
                ),
              );
            },
          ),
        );
      },
    );
  }
}
