import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_links.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/features/tasks/presentation/widgets/border_box.dart';
import 'package:ostad/features/tasks/presentation/widgets/steps_title.dart';
import 'package:ostad/features/tasks/presentation/widgets/upload_image.dart';
import 'package:ostad/core/utils/utils_image_picker_provider.dart';
import 'package:ostad/core/style/app_text_style.dart';  
import 'package:ostad/core/widgets/app_header.dart';
import 'package:ostad/core/widgets/app_warning_tip.dart';
import 'package:provider/provider.dart';

class LikeCoinmarketcapPage extends StatelessWidget {
  const LikeCoinmarketcapPage({super.key});
  @override
  Widget build(BuildContext context) {
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
                    headerText: AppString.voteForOstadInCoinMarketCap,
                    justIcon: true,
                  ),
                  AppDimens.vSpaceLarge,
                  BorderBox(
                    child: Column(
                      children: [
                        StepsTitle(),
                        AppDimens.vSpaceSmall,
                        AppWarningTip(
                          text: AppString.beforeStarting,
                        ),
                        AppDimens.vSpaceSmall,
                        Text(
                          AppString.likeCoinmarketcapDescription,
                        ),
                        AppDimens.vSpaceVerySmall,
                        Text(
                          AppLinks.coinMarketCap,
                          style: AppTextStyle.linkStyle,
                        ),
                        AppDimens.vSpaceMedium,
                        SizedBox(
                          width: double.maxFinite,
                        ),
                        Image.asset(
                          AppImages.coinMarketCap,
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                        AppDimens.vSpaceExtraLarge,
                      ],
                    ),
                  ),
                  AppDimens.vSpaceMedium,
                  UploadImage(
                    onTap: (imagePickerProvider, hasImages) {
                      if (hasImages) {
                      } else {
                        imagePickerProvider.pickImage(
                          source: ImageSource.gallery,
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
