import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/extensions/number_formatter_extension.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/widgets/app_loading.dart';
import 'package:dariwall/core/widgets/app_refresh_header.dart';
import 'package:dariwall/core/widgets/app_token_item.dart';
import 'package:dariwall/core/widgets/app_gradient_border_box.dart';
import 'package:dariwall/features/home/presentation/provider/my_balances_provider.dart';
import 'package:dariwall/features/home/presentation/provider/show_in_currency_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum ShowInCurrency {
  toman,
  tether,
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyBalancesProvider>().getMyBalances();
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppShadowBackground(
      child: ChangeNotifierProvider(
        create: (context) => getIt<ShowInCurrencyProvider>(),
        child: Selector2<MyBalancesProvider, ShowInCurrencyProvider,
            (MyBalancesStatus, ShowInCurrency)>(
          selector: (context, myBalancesProvider, showInCurrencyProvider) =>
              (myBalancesProvider.status, showInCurrencyProvider.showInCurrency),
          builder: (context, data, child) {
            final myBalancesProvider = context.read<MyBalancesProvider>();
            final showInCurrencyProvider = context.read<ShowInCurrencyProvider>();
            final isToman = data.$2 == ShowInCurrency.toman;

            if (data.$1 == MyBalancesStatus.loading && myBalancesProvider.myBalances == null) {
              return const AppLoading();
            }

            return AppRefresher(
              refreshController: _refreshController,
              onRefresh: () async {
                await myBalancesProvider.getMyBalances();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: AppDimens.paddingVeryLarge),
                      child: Column(
                        children: [
                          // total balance text
                          Text(
                            AppString.totalBalance,
                            style: theme.textTheme.titleMedium,
                          ),
                          AppDimens.vSpaceMedium,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppDimens.vSpaceMedium,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: AppDimens.verySmall,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: isToman
                                          ? myBalancesProvider.myBalances?.totalBalance.valueIrt ==
                                                  0
                                              ? '0'
                                              : myBalancesProvider.myBalances?.totalBalance.valueIrt
                                                      .toStringAsFixed(0)
                                                      .threeDigitsThree() ??
                                                  '0'
                                          : myBalancesProvider.myBalances?.totalBalance.valueUsd ==
                                                  0
                                              ? '0'
                                              : myBalancesProvider.myBalances?.totalBalance.valueUsd
                                                      .toStringAsFixed(2)
                                                      .threeDigitsThree() ??
                                                  '0',
                                      style: theme.textTheme.displayLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: isToman
                                              ? ' ${AppString.toman}'
                                              : ' ${AppString.tether}',
                                          style: theme.textTheme.titleLarge!.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ShowInCurrencyPopupMenu(
                                    selectedCurrency: data.$2,
                                    onSelected: (value) {
                                      showInCurrencyProvider.setCurrency(value);
                                    },
                                  ),
                                ],
                              )
                              // AppDimens.vSpaceMedium,
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     Text(
                              //       '+4.36%',
                              //       style: theme.textTheme.bodyLarge!.copyWith(
                              //         color: AppColor.priceIncreaseColor,
                              //       ),
                              //     ),
                              //     Text(
                              //       '+200,000 تومان',
                              //       style: theme.textTheme.bodyLarge!.copyWith(
                              //         color: AppColor.priceIncreaseColor,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                          AppDimens.vSpaceLarge,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium),
                            child: Row(
                              spacing: AppDimens.verySmall,
                              children: [
                                ActionItem(
                                  // onTap: () => context.pushNamed(AppRouteName.buy),
                                  onTap: () => context.pushNamed(AppRouteName.comingSoon),
                                  icon: AppIcons.buy,
                                  title: AppString.buy,
                                ),
                                ActionItem(
                                  // onTap: () => context.pushNamed(AppRouteName.swap),
                                  onTap: () => context.pushNamed(AppRouteName.comingSoon),
                                  icon: AppIcons.swap,
                                  title: AppString.swap,
                                ),
                                ActionItem(
                                  onTap: () => context.pushNamed(AppRouteName.chooseToken),
                                  icon: AppIcons.send,
                                  title: AppString.send,
                                ),
                                ActionItem(
                                  // onTap: () => context.pushNamed(AppRouteName.receive),
                                  onTap: () => context.pushNamed(AppRouteName.comingSoon),
                                  icon: AppIcons.scanQrCode,
                                  title: AppString.receive,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppDimens.vSpaceSmall,
                    // task list
                    Padding(
                      padding: EdgeInsets.all(AppDimens.paddingMedium),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: myBalancesProvider.myBalances?.balances?.length ?? 0,
                        separatorBuilder: (context, index) => AppDimens.vSpaceSmall,
                        itemBuilder: (context, index) {
                          return AppTokenItem(
                              tokenIcon: myBalancesProvider
                                      .myBalances?.balances![index].currencyInfo.currencyIcon ??
                                  AppIcons.solana,
                              tokenName: myBalancesProvider
                                      .myBalances?.balances![index].currencyInfo.currencyFaName ??
                                  '',
                              tokenTotalNumber:
                                  '${myBalancesProvider.myBalances?.balances![index].amount.toString().threeDigitsThree()} ${myBalancesProvider.myBalances?.balances![index].currencyInfo.currencyEnName}',
                              tokenTotalPrice: isToman
                                  ? '${myBalancesProvider.myBalances?.balances![index].valueIrt == 0 ? '0' : myBalancesProvider.myBalances?.balances![index].valueIrt.toStringAsFixed(0).threeDigitsThree()} ${AppString.toman}'
                                  : '${myBalancesProvider.myBalances?.balances![index].valueUsd == 0 ? '0' : myBalancesProvider.myBalances?.balances![index].valueUsd.toString().threeDigitsThree()} ${AppString.tether}');
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShowInCurrencyPopupMenu extends StatelessWidget {
  const ShowInCurrencyPopupMenu(
      {super.key, required this.selectedCurrency, required this.onSelected});

  final ShowInCurrency selectedCurrency;
  final void Function(ShowInCurrency) onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ShowInCurrency>(
      onSelected: onSelected,
      initialValue: selectedCurrency,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.4,
        minWidth: MediaQuery.of(context).size.width * 0.4,
      ),
      icon: Icon(
        CupertinoIcons.chevron_down,
        size: AppDimens.iconMedium,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: ShowInCurrency.toman,
          child: Row(
            children: [
              SvgPicture.asset(AppIcons.tomanIcon),
              AppDimens.hSpaceSmall,
              const Text(AppString.toman),
              Spacer(),
              if (selectedCurrency == ShowInCurrency.toman)
                Icon(
                  Icons.check,
                  color: AppColor.successColor,
                  size: AppDimens.iconLarge,
                ),
            ],
          ),
        ),
        PopupMenuItem(
          value: ShowInCurrency.tether,
          child: Row(
            children: [
              SvgPicture.asset(AppIcons.tetherIcon),
              AppDimens.hSpaceSmall,
              const Text(AppString.tether),
              Spacer(),
              if (selectedCurrency == ShowInCurrency.tether)
                Icon(
                  Icons.check,
                  color: AppColor.successColor,
                  size: AppDimens.iconLarge,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class ActionItem extends StatelessWidget {
  const ActionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final String icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: AppGradientBorderBox(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
        gradient: AppColor.strokeGradient,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColor.glassBoxColors,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimens.paddingMedium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppDimens.vSpaceVeryVerySmall,
                SvgPicture.asset(
                  icon,
                  height: AppDimens.iconVeryLarge,
                  width: AppDimens.iconVeryLarge,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  title,
                  style: theme.textTheme.bodyLarge,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
