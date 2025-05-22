import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/enum/mission_status_enum.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/widgets/app_description_dialog.dart';
import 'package:dariwall/core/widgets/app_loading.dart';
import 'package:dariwall/core/widgets/app_refresh_header.dart';
import 'package:dariwall/features/missions/data/model/mission_model.dart';
import 'package:dariwall/features/missions/domain/entity/mission_entity.dart';
import 'package:dariwall/features/missions/presentation/provider/get_missions_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Map<int, String> pageCorrespondingMissionCode = {
  1: AppRouteName.studentInfoMissions,
  2: AppRouteName.followTwitterMission,
  3: AppRouteName.likeTwitterMission,
  4: AppRouteName.retweetTwitterMission,
  5: AppRouteName.commentOnTwitterMission,
  6: AppRouteName.joinTelegramChannelMission,
  7: AppRouteName.joinDiscussionGroupMission,
  8: AppRouteName.likeCoinmarketcapMission,
  11: AppRouteName.joinDariwallTelegramChannelMission,
};

class MissionsPage extends StatefulWidget {
  const MissionsPage({super.key});

  @override
  State<MissionsPage> createState() => _MissionsPageState();
}

class _MissionsPageState extends State<MissionsPage> {
  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppShadowBackground(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppDimens.paddingLarge,
          AppDimens.paddingLarge,
          AppDimens.paddingLarge,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.missions,
              style: theme.textTheme.displaySmall,
            ),
            AppDimens.vSpaceLarge,
            Expanded(
              child: Consumer<GetMissionsProvider>(
                builder: (context, provider, child) {
                  if (provider.state == GetMissionsState.loading && provider.missions.isEmpty) {
                    return AppLoading();
                  }
                  //TODO: must be define error widget
                  // if (provider.state == GetMissionsState.error) {
                  //   return AppError(
                  //     onPressed: () {
                  //       provider.getMissions();
                  //     },
                  //   );
                  // }
                  return AppRefresher(
                    refreshController: _refreshController,
                    onRefresh: () async {
                      await provider.getMissions();
                    },
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.missions.length,
                      itemBuilder: (context, index) {
                        return MissionsItem(
                          index: index,
                          mission: provider.missions[index],
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MissionsItem extends StatelessWidget {
  const MissionsItem({
    super.key,
    required this.index,
    required this.mission,
  });

  final int index;
  final MissionModel mission;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimens.borderRadiusLarge),
      child: Material(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
          ),
          child: InkWell(
            onTap: () {
              if (mission.mission == null ||
                  mission.mission?.statusCode == MissionStatusEnum.rejected.index) {
                GoRouter.of(context).pushNamed(
                  pageCorrespondingMissionCode[mission.ruleCode]!,
                  extra: mission,
                );
              }
            },
            borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimens.paddingLarge,
                AppDimens.paddingSmall,
                AppDimens.paddingMedium,
                AppDimens.paddingSmall,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
                    child: SvgPicture.asset(AppIcons.coinAlt),
                  ),
                  SizedBox(
                    height: AppDimens.extraLarge,
                    child: VerticalDivider(
                      color: theme.colorScheme.secondary,
                      width: 0,
                      thickness: 0.5,
                    ),
                  ),
                  AppDimens.hSpaceVerySmall,
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppDimens.paddingSmall),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppDimens.verySmall,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            mission.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Row(
                            spacing: AppDimens.veryVerySmall,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${AppString.reward}: ',
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                '${mission.amount} ${mission.currencyInfo.currencyEnName}',
                                style: theme.textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.warningColor,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.chevron_right,
                          size: AppDimens.iconLarge,
                        ),
                      ),
                      if (mission.mission != null) MissionStatusWidget(status: mission.mission)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MissionStatusWidget extends StatelessWidget {
  const MissionStatusWidget({
    super.key,
    required this.status,
  });

  final MissionStatusEntity? status;

  Color getColor() {
    if (status?.statusCode == MissionStatusEnum.pending.index) {
      return AppColor.warningColor;
    } else if (status?.statusCode == MissionStatusEnum.confirmed.index) {
      return AppColor.successColor;
    } else if (status?.statusCode == MissionStatusEnum.rejected.index) {
      return AppColor.errorColor;
    } else {
      return AppColor.primaryColor;
    }
  }

  String getText() {
    if (status?.statusCode == MissionStatusEnum.pending.index) {
      return AppString.pending;
    } else if (status?.statusCode == MissionStatusEnum.confirmed.index) {
      return AppString.confirmed;
    } else if (status?.statusCode == MissionStatusEnum.rejected.index) {
      return AppString.rejected;
    } else {
      return AppString.notDone;
    }
  }

  IconData? getIcon() {
    if (status?.statusCode == MissionStatusEnum.pending.index) {
      return Icons.access_time;
    } else if (status?.statusCode == MissionStatusEnum.confirmed.index) {
      return Icons.check;
    } else if (status?.statusCode == MissionStatusEnum.rejected.index) {
      return Icons.close;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(AppDimens.borderRadiusVeryLarge),
      onTap: () {
        if (status?.description != null && status?.statusCode != MissionStatusEnum.notDone.index) {
          showDialog(
            context: context,
            builder: (context) {
              return AppDescriptionDialog(
                title: getText(),
                description: status!.description!,
                verticalAccentBarColor: getColor(),
              );
            },
          );
        }
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusVeryLarge),
          color: getColor().withAlpha(80),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppDimens.paddingVerySmall,
            horizontal: AppDimens.paddingSmall,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: AppDimens.veryVerySmall,
            children: [
              if (getIcon() != null)
                Icon(
                  getIcon(),
                  size: AppDimens.iconSmall,
                ),
              Text(
                getText(),
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
