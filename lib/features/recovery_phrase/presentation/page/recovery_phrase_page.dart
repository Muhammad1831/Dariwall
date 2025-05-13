import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/utils/utils_clipboard.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/bullet_text.dart';
import 'package:dariwall/features/create_new_wallet/presentation/provider/create_wallet_provider.dart';
import 'package:provider/provider.dart';

class RecoveryPhrasePage extends StatefulWidget {
  const RecoveryPhrasePage({super.key});

  @override
  State<RecoveryPhrasePage> createState() => _RecoveryPhrasePageState();
}

class _RecoveryPhrasePageState extends State<RecoveryPhrasePage> {
  bool isWrotePasswords = false;

  void _setIsWrotePasswords(bool value) {
    setState(() {
      isWrotePasswords = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final createWalletProvider = Provider.of<CreateWalletProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.paddingMedium,
            vertical: AppDimens.paddingLarge,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // page title
                Text(
                  AppString.securityRecoveryCodes,
                  style: theme.textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppDimens.vSpaceLarge,
                // warning box
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.error.withAlpha(10),
                    borderRadius: BorderRadius.circular(
                      AppDimens.borderRadiusMedium,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimens.paddingMedium,
                      horizontal: AppDimens.paddingLarge,
                    ),
                    child: Column(
                      spacing: AppDimens.small,
                      children: [
                        Text(
                          AppString.thisPasswordsIsYourKey,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.error,
                          ),
                        ),
                        Text(
                          AppString.warningRecoveryPhrase,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: theme.colorScheme.onError,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
                AppDimens.vSpaceSmall,
                // hint
                BulletText(
                  text: AppString.dontSendThisPasswordsToAnyOne,
                  bulletAlignment: CrossAxisAlignment.center,
                  bulletColor: theme.colorScheme.error,
                  textStyle: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
                AppDimens.vSpaceVeryVerySmall,
                // hint
                BulletText(
                  text: AppString.maintainProperly,
                  bulletAlignment: CrossAxisAlignment.center,
                  bulletColor: theme.colorScheme.error,
                  textStyle: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
                AppDimens.vSpaceMedium,
                // list 12 key word
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppDimens.verySmall,
                    crossAxisSpacing: AppDimens.verySmall,
                    childAspectRatio: 4,
                  ),
                  itemCount: createWalletProvider.wallet?.mnemonic.length ?? 12,
                  itemBuilder: (context, index) {
                    return KeyWordItem(
                      index: index,
                    );
                  },
                ),
                AppDimens.vSpaceLarge,
                // save in clipboard
                GestureDetector(
                  onTap: () async {
                    final words = createWalletProvider.wallet?.mnemonic ?? [];
                    final text = words.join(' ');
                    await UtilsClipboard.copyToClipboard(
                      text: text,
                      successMessage: AppMessage.copiedPasswords,
                    );
                  },
                  child: Row(
                    spacing: AppDimens.veryVerySmall,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.copy,
                      ),
                      Text(
                        AppString.saveInClipboard,
                        style: theme.textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: isWrotePasswords,
                      onChanged: (value) {
                        _setIsWrotePasswords(value ?? false);
                      },
                    ),
                    Expanded(
                      child: Text(
                        AppString.wrotePasswords,
                      ),
                    ),
                  ],
                ),
                AppDimens.vSpaceSmall,
                AppButton(
                  text: AppString.enterToApp,
                  onTap: () {
                    if (isWrotePasswords) {
                      context.goNamed(AppRouteName.home);
                    }
                  },
                  bgColor: isWrotePasswords ? null : theme.disabledColor,
                ),
                AppDimens.vSpaceVerySmall,
                AppButton(
                  text: AppString.connectWalletToEmail,
                  onTap: () {
                    if (isWrotePasswords) {
                      context.pushNamed(AppRouteName.connectWalletToEmail);
                    }
                  },
                  bgColor: Colors.transparent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// wrong pigeon dragon sketch intact soon tortoise provide assault battle ranch evil
class KeyWordItem extends StatelessWidget {
  const KeyWordItem({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppDimens.paddingSmall,
          AppDimens.paddingVerySmall,
          AppDimens.paddingMedium,
          AppDimens.paddingVerySmall,
        ),
        child: Row(
          children: [
            Text(
              '${index + 1}',
              style: theme.textTheme.bodySmall!.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            AppDimens.hSpaceSmall,
            VerticalDivider(
              width: 0,
              thickness: 2,
              color: theme.colorScheme.surfaceContainerHighest,
            ),
            Expanded(
              child: Center(
                child: Consumer<CreateWalletProvider>(
                  builder: (context, createWalletProvider, child) {
                    return Text(
                      createWalletProvider.wallet?.mnemonic[index] ?? '',
                      maxLines: 1,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
