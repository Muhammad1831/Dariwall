import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/enum/type_of_send_enum.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:dariwall/features/home/domain/entity/balances_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SendToPage extends StatefulWidget {
  const SendToPage({super.key, required this.balance, required this.typeOfSend});
  final BalancesEntity balance;
  final TypeOfSendEnum typeOfSend;

  @override
  State<SendToPage> createState() => _SendToPageState();
}

class _SendToPageState extends State<SendToPage> {
  final walletAddressController = TextEditingController();
  final walletAddressFocusNode = FocusNode();

  @override
  void dispose() {
    walletAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                TextField(
                  controller: walletAddressController,
                  focusNode: walletAddressFocusNode,
                  decoration: InputDecoration(
                    hintText: AppString.enterDestnationWalletAddress,
                    filled: false,
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty && value.length >= 32) {
                      context.pushNamed(
                        AppRouteName.send,
                        extra: {
                          'balance': widget.balance,
                          'typeOfSend': widget.typeOfSend,
                          'walletAddress': value,
                        },
                      );
                      walletAddressController.clear();
                    }
                  },
                  onTapOutside: (event) {
                    walletAddressFocusNode.unfocus();
                  },
                ),
                Spacer(),
                ValueListenableBuilder(
                  valueListenable: walletAddressController,
                  builder: (context, value, child) {
                    return AppButton(
                      text: AppString.next,
                      bgColor: value.text.isNotEmpty && value.text.length >= 32
                          ? null
                          : Theme.of(context).disabledColor,
                      onTap: () {
                        if (value.text.isNotEmpty && value.text.length >= 32) {
                          context.pushNamed(
                            AppRouteName.send,
                            extra: {
                              'balance': widget.balance,
                              'typeOfSend': widget.typeOfSend,
                              'walletAddress': value,
                            },
                          );
                          walletAddressController.clear();
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
