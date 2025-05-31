import 'package:dariwall/features/missions/data/model/mission_model.dart';
import 'package:dariwall/features/missions/presentation/provider/parax_provider/check_join_parax_telegram_channel_provider.dart';
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
import 'package:dariwall/features/missions/presentation/widgets/steps_title.dart';
import 'package:dariwall/core/style/app_text_style.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_warning_tip.dart';
import 'package:provider/provider.dart';

class CheckJoinParaxTelegramChannelPage extends StatelessWidget {
  const CheckJoinParaxTelegramChannelPage({super.key, required this.mission});
  final MissionModel mission;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => getIt<CheckJoinParaxTelegramChannelProvider>(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppDimens.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppHeader(
                    headerText: AppString.joinParabolicInTelegram,
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
                    AppString.joinParabolicInTelegramDescription,
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
                      UtilsLaunchUrl.launchURL(url: AppLinks.telegramParax);
                    },
                    child: Center(
                      child: Text(
                        AppLinks.telegramParax,
                        style: AppTextStyle.linkStyle,
                      ),
                    ),
                  ),
                  AppDimens.vSpaceMedium,
                  Center(
                    child: Image.asset(
                      AppImages.telegramParax,
                      height: 250,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  AppDimens.vSpaceLarge,
                  Divider(),
                  AppDimens.vSpaceSmall,
                  // reward text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${AppString.reward} :'),
                      Text(
                        '${mission.amount.toString()} ${mission.currencyInfo.currencyEnName}',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColor.warningColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  AppDimens.vSpaceSmall,
                  Spacer(),
                  Selector<CheckJoinParaxTelegramChannelProvider,
                      CheckJoinParaxTelegramChannelStatus>(
                    selector: (context, checkJoinParaxTelegramChannelProvider) =>
                        checkJoinParaxTelegramChannelProvider.status,
                    builder: (context, value, child) {
                      if (value == CheckJoinParaxTelegramChannelStatus.success) {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          context.pop();
                        });
                      }
                      return AppButton(
                        isLoading: value == CheckJoinParaxTelegramChannelStatus.loading,
                        text: AppString.check,
                        onTap: () {
                          context
                              .read<CheckJoinParaxTelegramChannelProvider>()
                              .checkJoinParaxTelegramChannel();
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
