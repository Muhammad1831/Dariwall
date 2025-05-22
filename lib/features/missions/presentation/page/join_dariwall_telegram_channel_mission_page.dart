import 'package:dariwall/features/missions/data/model/mission_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_links.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/style/app_text_style.dart';
import 'package:dariwall/core/utils/utils_launch_url.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/bullet_text.dart';
import 'package:dariwall/features/missions/presentation/provider/join_dariwall_telegram_channel_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/widgets/steps_title.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_warning_tip.dart';
import 'package:provider/provider.dart';

class JoinDariwallTelegramChannelMissionPage extends StatelessWidget {
  const JoinDariwallTelegramChannelMissionPage({super.key, required this.mission});
  final MissionModel mission;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => getIt<JoinDariwallTelegramChannelMissionProvider>(),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(AppDimens.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeader(
                  headerText: AppString.joinDariwallTelegramChannel,
                  justIcon: true,
                ),
                AppDimens.vSpaceLarge,
                StepsTitle(),
                AppDimens.vSpaceSmall,
                AppWarningTip(
                  text: AppString.beforeStarting,
                ),
                AppDimens.vSpaceMedium,
                Text(
                  AppString.joinDariwallTelegramChannelDescription,
                  textAlign: TextAlign.justify,
                ),
                AppDimens.vSpaceMedium,
                BulletText(
                  text: AppString.justClickAndJoinDariwallTelegramChannel,
                  bulletAlignment: CrossAxisAlignment.center,
                ),
                AppDimens.vSpaceMedium,
                GestureDetector(
                  onTap: () {
                    UtilsLaunchUrl.launchURL(url: AppLinks.telegramDariWall);
                  },
                  child: Center(
                    child: Text(
                      AppLinks.telegramDariWall,
                      style: AppTextStyle.linkStyle,
                    ),
                  ),
                ),
                Spacer(),
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
                Selector<JoinDariwallTelegramChannelMissionProvider,
                    JoinDariwallTelegramChannelMissionStatus>(
                  selector: (context, joinDariwallTelegramChannelMissionProvider) =>
                      joinDariwallTelegramChannelMissionProvider.status,
                  builder: (context, value, child) {
                    if (value == JoinDariwallTelegramChannelMissionStatus.success) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        context.pop();
                      });
                    }
                    return AppButton(
                      isLoading: value == JoinDariwallTelegramChannelMissionStatus.loading,
                      text: AppString.check,
                      onTap: () {
                        context
                            .read<JoinDariwallTelegramChannelMissionProvider>()
                            .joinDariwallTelegramChannelMission();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
