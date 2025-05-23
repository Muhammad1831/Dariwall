import 'package:dariwall/features/missions/data/model/mission_model.dart';
import 'package:dariwall/features/missions/presentation/provider/parax_provider/like_parax_in_coinmarketcap_mission_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_links.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/utils/utils_image_picker_provider.dart';
import 'package:dariwall/core/style/app_text_style.dart';
import 'package:dariwall/core/utils/utils_launch_url.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_warning_tip.dart';
import 'package:dariwall/features/missions/presentation/widgets/steps_title.dart';
import 'package:dariwall/features/missions/presentation/widgets/upload_image.dart';
import 'package:provider/provider.dart';

class LikeParaxInCoinmarketcapPage extends StatelessWidget {
  const LikeParaxInCoinmarketcapPage({super.key, required this.mission});
  final MissionModel mission;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt<LikeParaxInCoinmarketcapMissionProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<UtilsImagePickerProvider>(),
        ),
      ],
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
                    headerText: AppString.likeParabolicInCoinMarketCap,
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
                    AppString.likeCoinmarketcapDescription,
                  ),
                  AppDimens.vSpaceLarge,
                  GestureDetector(
                    onTap: () {
                      UtilsLaunchUrl.launchURL(url: AppLinks.paraxCoinmarketcap);
                    },
                    child: Text(
                      AppLinks.paraxCoinmarketcap,
                      style: AppTextStyle.linkStyle,
                    ),
                  ),
                  AppDimens.vSpaceMedium,
                  SizedBox(
                    width: double.maxFinite,
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimens.borderRadiusVeryLarge),
                      child: Image.asset(
                        AppImages.paraxCoinmarketcap,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
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
                  AppDimens.vSpaceVeryLarge,
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
                  Selector2<LikeParaxInCoinmarketcapMissionProvider, UtilsImagePickerProvider,
                      (LikeParaxInCoinmarketcapMissionStatus, MultipartFile?)>(
                    selector: (context, likeParaxInCoinmarketcapMissionProvider,
                            utilsImagePickerProvider) =>
                        (
                      likeParaxInCoinmarketcapMissionProvider.status,
                      utilsImagePickerProvider.imageFile
                    ),
                    builder: (context, value, child) {
                      final likeParaxInCoinmarketcapMissionProvider =
                          context.read<LikeParaxInCoinmarketcapMissionProvider>();
                      final imageProvider = context.read<UtilsImagePickerProvider>();

                      if (LikeParaxInCoinmarketcapMissionStatus.success ==
                          likeParaxInCoinmarketcapMissionProvider.status) {
                        WidgetsBinding.instance.addPostFrameCallback(
                          (_) => context.pop(),
                        );
                      }
                      return AppButton(
                        isLoading: likeParaxInCoinmarketcapMissionProvider.status ==
                            LikeParaxInCoinmarketcapMissionStatus.loading,
                        text: AppString.send,
                        bgColor: imageProvider.imageFile != null
                            ? theme.colorScheme.primary
                            : theme.disabledColor,
                        onTap: () {
                          if (imageProvider.imageFile != null) {
                            likeParaxInCoinmarketcapMissionProvider.likeParaxInCoinmarketcap(
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
