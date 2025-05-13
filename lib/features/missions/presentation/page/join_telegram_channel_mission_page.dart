import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_links.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/utils/utils_launch_url.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/features/missions/presentation/provider/join_telegram_channel_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/widgets/steps_title.dart';
import 'package:dariwall/core/style/app_text_style.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_warning_tip.dart';
import 'package:provider/provider.dart';

class JoinTelegramChannelMissionPage extends StatelessWidget {
  const JoinTelegramChannelMissionPage({super.key, required this.amount});
  final double amount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => getIt<JoinTelegramChannelMissionProvider>(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppDimens.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeader(
                    headerText: AppString.joinOstadInTelegram,
                    justIcon: true,
                  ),
                  AppDimens.vSpaceLarge,
                  StepsTitle(),
                  AppDimens.vSpaceSmall,
                  AppWarningTip(
                    text: AppString.beforeStarting,
                  ),
                  AppDimens.vSpaceLarge,
                  Text(
                    AppString.joinOstadInTelegramDescription,
                    style: theme.textTheme.titleSmall,
                    textAlign: TextAlign.justify,
                  ),
                  AppDimens.vSpaceMedium,
                  Text(
                    AppString.justClickAndJoin,
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  AppDimens.vSpaceMedium,
                  GestureDetector(
                    onTap: () {
                      UtilsLaunchUrl.launchURL(url: AppLinks.telegramOstad);
                    },
                    child: Center(
                      child: Text(
                        AppLinks.telegramOstad,
                        style: AppTextStyle.linkStyle,
                      ),
                    ),
                  ),
                  AppDimens.vSpaceMedium,
                  Center(
                    child: Image.asset(
                      AppImages.telegram,
                      height: 300,
                      width: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  AppDimens.vSpaceVeryLarge,
                  Text(
                    AppString.noNeedToSendImageOrManualVerification,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  AppDimens.vSpaceMedium,
                  Divider(),
                  AppDimens.vSpaceSmall,
                  // reward text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${AppString.reward} :'),
                      Text(
                        '${amount.toString()} ${AppString.usdt}',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColor.warningColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  AppDimens.vSpaceSmall,
                  Selector<JoinTelegramChannelMissionProvider, JoinTelegramChannelMissionStatus>(
                    selector: (context, joinTelegramChannelMissionProvider) =>
                        joinTelegramChannelMissionProvider.status,
                    builder: (context, value, child) {
                      if (value == JoinTelegramChannelMissionStatus.success) {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          context.pop();
                        });
                      }
                      return AppButton(
                        isLoading: value == JoinTelegramChannelMissionStatus.loading,
                        text: AppString.check,
                        onTap: () {
                          context
                              .read<JoinTelegramChannelMissionProvider>()
                              .joinTelegramChannelMission();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
