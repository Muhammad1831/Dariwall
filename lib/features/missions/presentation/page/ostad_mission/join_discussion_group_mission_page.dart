import 'package:dariwall/features/missions/data/model/mission_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/join_discussion_group_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/widgets/steps_title.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_warning_tip.dart';
import 'package:provider/provider.dart';

class JoinDiscussionGroupMissionPage extends StatelessWidget {
  const JoinDiscussionGroupMissionPage({super.key, required this.mission});
  final MissionModel mission;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => getIt<JoinDiscussionGroupMissionProvider>(),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(AppDimens.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeader(
                  headerText: AppString.joinOstadInDiscussionGroup,
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
                  AppString.joinOstadInDiscussionGroupDescription,
                  textAlign: TextAlign.justify,
                ),
                AppDimens.vSpaceMedium,
                Text(
                  AppString.noNeedToSendImageOrManualVerification,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.justify,
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
                Selector<JoinDiscussionGroupMissionProvider, JoinDiscussionGroupMissionStatus>(
                  selector: (context, joinDiscussionGroupMissionProvider) =>
                      joinDiscussionGroupMissionProvider.status,
                  builder: (context, value, child) {
                    if (value == JoinDiscussionGroupMissionStatus.success) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        context.pop();
                      });
                    }
                    return AppButton(
                      isLoading: value == JoinDiscussionGroupMissionStatus.loading,
                      text: AppString.check,
                      onTap: () {
                        context
                            .read<JoinDiscussionGroupMissionProvider>()
                            .joinDiscussionGroupMission();
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
