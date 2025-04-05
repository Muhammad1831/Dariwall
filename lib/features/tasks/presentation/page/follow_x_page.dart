import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_links.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/features/tasks/presentation/widgets/border_box.dart';
import 'package:ostad/features/tasks/presentation/widgets/icon_between_text.dart';
import 'package:ostad/features/tasks/presentation/widgets/steps_title.dart';
import 'package:ostad/features/tasks/presentation/widgets/upload_image.dart';
import 'package:ostad/core/utils/utils_image_picker_provider.dart';
import 'package:ostad/core/style/app_text_style.dart';
import 'package:ostad/core/widgets/app_header.dart';
import 'package:ostad/core/widgets/app_warning_tip.dart';
import 'package:provider/provider.dart';

class FollowXPage extends StatelessWidget {
  const FollowXPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => UtilsImagePickerProvider(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.medium,
                vertical: AppDimens.large,
              ),
              child: Column(
                children: [
                  AppHeader(
                    headerText: AppString.followOstadInX,
                    justIcon: true,
                  ),
                  AppDimens.vSpaceLarge,
                  BorderBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StepsTitle(),
                        AppDimens.vSpaceSmall,
                        AppWarningTip(
                          text: AppString.beforeStarting,
                        ),
                        AppDimens.vSpaceSmall,
                        Text(
                          AppString.followOstadInXDescription,
                          style: theme.textTheme.titleSmall,
                        ),
                        AppDimens.vSpaceVerySmall,
                        Center(
                          child: Text(
                            AppLinks.x,
                            style: AppTextStyle.linkStyle,
                          ),
                        ),
                        AppDimens.vSpaceVerySmall,
                        Center(
                          child: Image.asset(
                            AppImages.followX,
                            height: 300,
                            width: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                        AppDimens.vSpaceSmall,
                        Text(
                          AppString.clickOnFollowButton,
                          style: theme.textTheme.labelMedium,
                        ),
                        AppDimens.vSpaceExtraLarge,
                        Text(
                          AppString.likeAndRepostPost,
                          style: theme.textTheme.titleSmall,
                        ),
                        Center(
                          child: Text(
                            AppLinks.caPost,
                            style: AppTextStyle.linkStyle,
                          ),
                        ),
                        AppDimens.vSpaceMedium,
                        Center(
                          child: Image.asset(
                            AppImages.caPost,
                            height: 100,
                            width: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                        AppDimens.vSpaceSmall,
                        Text(
                          AppString.afterEnterPost,
                          style: theme.textTheme.titleSmall,
                        ),
                        AppDimens.vSpaceSmall,
                        IconBetweenText(
                          startText: AppString.onLikeButton,
                          endText: AppString.click,
                          icon: AppIcons.heart,
                        ),
                        AppDimens.vSpaceVerySmall,
                        IconBetweenText(
                          startText: AppString.aComment,
                          endText: AppString.write,
                          icon: AppIcons.comment,
                        ),
                        AppDimens.vSpaceVerySmall,
                        IconBetweenText(
                          startText: AppString.onRetweetButton,
                          endText: AppString.clickAndChooseRetweet,
                          icon: AppIcons.retweet,
                        ),
                        AppDimens.vSpaceExtraLarge,
                        Text(
                          AppString.uploadImagesFromEachStep,
                          style: theme.textTheme.titleSmall,
                        ),
                        AppDimens.vSpaceSmall,
                        Text(
                          AppString.uploadImagesFromEachStepDescription,
                          style: theme.textTheme.labelMedium,
                          textAlign: TextAlign.justify,
                        ),
                        AppDimens.vSpaceLarge,
                      ],
                    ),
                  ),
                  AppDimens.vSpaceMedium,
                  UploadImage(
                    isMultiImage: true,
                    onTap: (imagePickerProvider, hasImages) {
                      if (hasImages) {
                      } else {
                        imagePickerProvider.pickImage(
                          source: ImageSource.gallery,
                          isMultiImage: true,
                        );
                      }
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
