import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostad/constant/app_color.dart';
import 'package:ostad/constant/app_dimens.dart';
import 'package:ostad/constant/app_images.dart';
import 'package:ostad/constant/app_string.dart';
import 'package:ostad/pages/sign_up/sign_up_page.dart';
import 'package:ostad/widgets/app_header.dart';

List<String> taskNumbers = [
  '۰',
  '۱',
  '۲',
  '۳',
  '۴',
  '۵',
  '۶',
  '۷',
  '۸',
  '۹',
  '۱۰',
];

class LearnAndGuidePage extends StatelessWidget {
  const LearnAndGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.medium,
              vertical: AppDimens.large,
            ),
            child: Column(
              children: [
                AppHeader(headerText: AppString.learnAndGuide),
                AppDimens.vSpaceExtraLarge,

                //------------------------------Task 1-------------------------------------

                TaskNumber(taskNumber: taskNumbers[1]),
                AppDimens.vSpaceVerySmall,
                Text(
                  AppString.downloadAndCreatePhantomWallet,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppDimens.vSpaceSmall,
                SvgPicture.asset(
                  AppImages.phantomLogo,
                  width: 200.w,
                  height: 40.h,
                  fit: BoxFit.fitWidth,
                ),
                AppDimens.vSpaceSmall,
                Text(
                  AppString.downloadPhantomWallet,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: AppColor.infoColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.infoColor,
                  ),
                ),
                AppDimens.vSpaceSmall,
                BulletText(
                  text: AppString.firstDownloadAndCreatePhantomWallet,
                  textStyle: theme.textTheme.bodySmall,
                  bulletColor: theme.colorScheme.onPrimary,
                ),
                AppDimens.vSpaceVeryVerySmall,
                BulletText(
                  text: AppString.afterDownloadAndCreatePhantomWallet,
                  textStyle: theme.textTheme.bodySmall,
                  bulletColor: theme.colorScheme.onPrimary,
                ),
                AppDimens.vSpaceVeryVerySmall,
                BulletText(
                  text: AppString.confirmYourAccount,
                  textStyle: theme.textTheme.bodySmall,
                  bulletColor: theme.colorScheme.onPrimary,
                ),
                AppDimens.vSpaceExtraLarge,

                //------------------------------Task 2-------------------------------------

                TaskNumber(taskNumber: taskNumbers[2]),
                AppDimens.vSpaceVerySmall,
                Text(
                  AppString.doneMission,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppDimens.vSpaceSmall,
                BulletText(
                  text: AppString.goToMission,
                  textStyle: theme.textTheme.bodySmall,
                  bulletColor: theme.colorScheme.onPrimary,
                ),
                AppDimens.vSpaceVeryVerySmall,
                BulletText(
                  text: AppString.doTheTasks,
                  textStyle: theme.textTheme.bodySmall,
                  bulletColor: theme.colorScheme.onPrimary,
                ),
                AppDimens.vSpaceVeryVerySmall,
                BulletText(
                  text: AppString.uploadTheImage,
                  textStyle: theme.textTheme.bodySmall,
                  bulletColor: theme.colorScheme.onPrimary,
                ),
                AppDimens.vSpaceSmall,
                Text(
                  AppString.viewAndDoMission,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),

                AppDimens.vSpaceExtraLarge,

                //------------------------------Task 3-------------------------------------

                TaskNumber(taskNumber: taskNumbers[3]),
                AppDimens.vSpaceVerySmall,
                Text(
                  AppString.waitingForConfirmation,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppDimens.vSpaceSmall,
                BulletText(
                  text: AppString.afterUploadingTheImages,
                  textStyle: theme.textTheme.bodySmall,
                  bulletColor: theme.colorScheme.onPrimary,
                ),
                AppDimens.vSpaceVeryVerySmall,
                BulletText(
                  text: AppString.thisProcessCanTakeUpTo48Hours,
                  textStyle: theme.textTheme.bodySmall,
                  bulletColor: theme.colorScheme.onPrimary,
                ),

                AppDimens.vSpaceExtraLarge,

                //------------------------------Task 4-------------------------------------

                TaskNumber(taskNumber: taskNumbers[4]),
                AppDimens.vSpaceVerySmall,
                Text(
                  AppString.receiveReward,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppDimens.vSpaceSmall,
                BulletText(
                  text: AppString.afterConfirmation,
                  textStyle: theme.textTheme.bodySmall,
                  bulletColor: theme.colorScheme.onPrimary,
                ),
                AppDimens.vSpaceVeryVerySmall,
                BulletText(
                  text: AppString.convertToOstadToken,
                  textStyle: theme.textTheme.bodySmall,
                  bulletColor: theme.colorScheme.onPrimary,
                ),

                AppDimens.vSpaceExtraLarge,

                //------------------------------Task 5-------------------------------------

                TaskNumber(taskNumber: taskNumbers[5]),
                AppDimens.vSpaceVerySmall,
                Text(
                  AppString.buyTokenAndGetLicense,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppDimens.vSpaceSmall,
                BulletText(
                  text: AppString.afterConvertSolanaToOstadToken,
                  textStyle: theme.textTheme.bodySmall,
                  bulletColor: theme.colorScheme.onPrimary,
                ),
                AppDimens.vSpaceVeryVerySmall,
                BulletText(
                  text: AppString.afterUploadingTheImage,
                  textStyle: theme.textTheme.bodySmall,
                  bulletColor: theme.colorScheme.onPrimary,
                ),

                AppDimens.vSpaceExtraLarge,

                //------------------------------Task 6-------------------------------------

                TaskNumber(taskNumber: taskNumbers[6]),
                AppDimens.vSpaceVerySmall,
                Text(
                  AppString.participateInEvents,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppDimens.vSpaceSmall,
                BulletText(
                  text: AppString.participateInEventsDescription,
                  textStyle: theme.textTheme.bodySmall,
                  bulletColor: theme.colorScheme.onPrimary,
                ),
                AppDimens.vSpaceExtraLarge,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskNumber extends StatelessWidget {
  const TaskNumber({
    super.key,
    required this.taskNumber,
  });

  final String taskNumber;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: AppDimens.extraLarge,
      width: AppDimens.extraLarge,
      decoration: BoxDecoration(
        gradient: AppColor.cardGradient,
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
      ),
      child: Center(
        child: Text(
          taskNumber,
          style: theme.textTheme.displayLarge!.copyWith(
            color: AppColor.blueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
