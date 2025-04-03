import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/widgets/app_otp.dart';
import 'package:ostad/core/widgets/bullet_text.dart';
import 'package:ostad/core/widgets/app_button.dart';

// ignore: must_be_immutable
class OtpStep extends StatelessWidget {
  OtpStep({super.key, required this.onTapContinue});
  final Function(String) onTapContinue;
  String _otp = '';
  int numberOfField = 6;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // description
          BulletText(
            text: AppString.enterYourPhoneNumberForValidation,
          ),
          AppDimens.vSpaceVerySmall,
          // code sent to
          Text(
            AppString.codeSentTo('09181112233'),
          ),
          AppDimens.vSpaceVerySmall,
          // edit phone number
          InkWell(
            onTap: () {},
            child: Row(
              spacing: AppDimens.veryVerySmall,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.editSquare),
                Text(
                  AppString.editPhoneNumber,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: AppColor.infoColor,
                  ),
                )
              ],
            ),
          ),
          AppDimens.vSpaceLarge,
          AppOtp(
            onChanged: (otp) {
              _otp = otp;
            },
          ),
          AppDimens.vSpaceLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppDimens.verySmall,
            children: [
              Text(
                AppString.codeNotSent,
              ),
              Text(
                AppString.sentCodeAgain,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: AppColor.infoColor,
                ),
              ),
            ],
          ),
          AppDimens.vSpaceMedium,
          Spacer(),
          // continu button
          AppButton(
            text: AppString.continueText,
            onTap: () {
              if (_otp.length == numberOfField) {
                onTapContinue(_otp);
              }
            },
          )
        ],
      ),
    );
  }
}
