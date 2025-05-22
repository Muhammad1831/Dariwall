import 'package:dariwall/features/missions/data/model/mission_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_links.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/utils/utils_launch_url.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/features/missions/presentation/provider/retweet_twitter_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/widgets/icon_between_text.dart';
import 'package:dariwall/features/missions/presentation/widgets/steps_title.dart';
import 'package:dariwall/features/missions/presentation/widgets/upload_image.dart';
import 'package:dariwall/core/utils/utils_image_picker_provider.dart';
import 'package:dariwall/core/style/app_text_style.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_warning_tip.dart';
import 'package:provider/provider.dart';

class RetweetTwitterMissionPage extends StatelessWidget {
  const RetweetTwitterMissionPage({super.key, required this.mission});
  final MissionModel mission;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt<UtilsImagePickerProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<RetweetTwitterMissionProvider>(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppDimens.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeader(
                    headerText: AppString.retweetTwitterPost,
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
                    AppString.retweetCAPost,
                    style: theme.textTheme.titleSmall,
                  ),
                  AppDimens.vSpaceMedium,
                  // twitter link
                  GestureDetector(
                    onTap: () async {
                      await UtilsLaunchUrl.launchURL(url: AppLinks.caPost);
                    },
                    child: Text(
                      AppLinks.caPost,
                      style: AppTextStyle.linkStyle,
                    ),
                  ),
                  AppDimens.vSpaceMedium,
                  // image of post
                  Center(
                    child: Image.asset(
                      AppImages.caPost,
                      height: 100,
                      width: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  AppDimens.vSpaceMedium,
                  Text(
                    AppString.afterEnterPost,
                    style: theme.textTheme.titleSmall!.copyWith(color: theme.colorScheme.onSurface),
                  ),
                  AppDimens.vSpaceSmall,
                  IconBetweenText(
                    startText: AppString.onRetweetButton,
                    endText: AppString.clickAndChooseRetweet,
                    icon: AppIcons.retweet,
                  ),
                  AppDimens.vSpaceLarge,
                  Text(
                    AppString.uploadImageForCompleteProcess,
                    style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.onSurface),
                  ),
                  AppDimens.vSpaceSmall,
                  AppDimens.vSpaceSmall,
                  Text(AppString.uploadImage, style: theme.textTheme.bodyMedium),
                  AppDimens.vSpaceMedium,
                  UploadImage(), AppDimens.vSpaceMedium,
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
                  Selector2<RetweetTwitterMissionProvider, UtilsImagePickerProvider,
                      (RetweetTwitterMissionStatus, MultipartFile?)>(
                    selector: (context, retweetTwitterMissionProvider, utilsImagePickerProvider) =>
                        (retweetTwitterMissionProvider.status, utilsImagePickerProvider.imageFile),
                    builder: (context, value, child) {
                      final retweetTwitterMissionProvider =
                          context.read<RetweetTwitterMissionProvider>();
                      final imageProvider = context.read<UtilsImagePickerProvider>();

                      if (RetweetTwitterMissionStatus.success ==
                          retweetTwitterMissionProvider.status) {
                        WidgetsBinding.instance.addPostFrameCallback(
                          (_) => context.pop(),
                        );
                      }
                      return AppButton(
                        isLoading: retweetTwitterMissionProvider.status ==
                            RetweetTwitterMissionStatus.loading,
                        text: AppString.send,
                        bgColor: imageProvider.imageFile != null
                            ? theme.colorScheme.primary
                            : theme.disabledColor,
                        onTap: () {
                          if (imageProvider.imageFile != null) {
                            retweetTwitterMissionProvider
                                .retweetTwitterMission(imageFile: imageProvider.imageFile!);
                          }
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
