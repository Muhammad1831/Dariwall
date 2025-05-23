import 'package:dariwall/features/missions/data/model/mission_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_links.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/style/app_text_style.dart';
import 'package:dariwall/core/utils/utils_image_picker_provider.dart';
import 'package:dariwall/core/utils/utils_launch_url.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_warning_tip.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/comment_on_twitter_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/widgets/icon_between_text.dart';
import 'package:dariwall/features/missions/presentation/widgets/steps_title.dart';
import 'package:dariwall/features/missions/presentation/widgets/upload_image.dart';
import 'package:provider/provider.dart';

class CommentOnTwitterMissionPage extends StatelessWidget {
  const CommentOnTwitterMissionPage({super.key, required this.mission});

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
          create: (context) => getIt<CommentOnTwitterMissionProvider>(),
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
                    headerText: AppString.commentOnTwitterPost,
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
                    AppString.commentOnCAPost,
                    style: theme.textTheme.titleSmall,
                  ),
                  AppDimens.vSpaceMedium,
                  // link of post
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
                    startText: AppString.aComment,
                    endText: AppString.write,
                    icon: AppIcons.comment,
                  ),
                  AppDimens.vSpaceLarge,
                  Text(
                    AppString.uploadImageForCompleteProcess,
                    style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.onSurface),
                  ),
                  AppDimens.vSpaceMedium,
                  // upload image text
                  Text(AppString.uploadImage, style: theme.textTheme.bodyMedium),
                  AppDimens.vSpaceMedium,
                  // upload image
                  UploadImage(),
                  AppDimens.vSpaceMedium,
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
                  // send button
                  Selector2<CommentOnTwitterMissionProvider, UtilsImagePickerProvider,
                      (CommentOnTwitterMissionStatus, MultipartFile?)>(
                    selector:
                        (context, commentOnTwitterMissionProvider, utilsImagePickerProvider) => (
                      commentOnTwitterMissionProvider.status,
                      utilsImagePickerProvider.imageFile,
                    ),
                    builder: (context, value, child) {
                      final commentOnTwitterMissionProvider =
                          context.read<CommentOnTwitterMissionProvider>();
                      final imageProvider = context.read<UtilsImagePickerProvider>();

                      if (CommentOnTwitterMissionStatus.success ==
                          commentOnTwitterMissionProvider.status) {
                        WidgetsBinding.instance.addPostFrameCallback(
                          (_) => context.pop(),
                        );
                      }
                      return AppButton(
                        isLoading: commentOnTwitterMissionProvider.status ==
                            CommentOnTwitterMissionStatus.loading,
                        text: AppString.send,
                        bgColor: imageProvider.imageFile != null
                            ? theme.colorScheme.primary
                            : theme.disabledColor,
                        onTap: () {
                          if (imageProvider.imageFile != null) {
                            commentOnTwitterMissionProvider.commentOnTwitterMission(
                                imageFile: imageProvider.imageFile!);
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
