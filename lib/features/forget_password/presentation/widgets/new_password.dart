import 'package:flutter/material.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/widgets/bullet_text.dart';
import 'package:ostad/core/widgets/app_button.dart';
import 'package:ostad/core/widgets/app_text_field.dart';

class NewPasswordStep extends StatefulWidget {
  const NewPasswordStep({
    super.key,
    required this.onTapContinue,
  });

  final VoidCallback onTapContinue;

  @override
  State<NewPasswordStep> createState() => _NewPasswordStepState();
}

class _NewPasswordStepState extends State<NewPasswordStep> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _repeatPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppDimens.vSpaceExtraLarge,
          AppTextFormField(
            controller: _password,
            hintText: AppString.enterPassword,
            obscureText: true,
            title: AppString.newPassword,
            validationType: ValidationType.password,
          ),
          AppDimens.vSpaceMedium,
          AppTextFormField(
            controller: _repeatPassword,
            hintText: AppString.enterRepeatPassword,
            obscureText: true,
            title: AppString.newRepeatPassword,
            validationType: ValidationType.repeatPassword,
          ),
          AppDimens.vSpaceMedium,
          BulletText(text: AppString.minimumPasswordCharacter),
          AppDimens.vSpaceVerySmall,
          BulletText(text: AppString.dontUseSimplePassword),
          AppDimens.vSpaceVerySmall,
          BulletText(text: AppString.useUperLowerSpecialSign),
          const Spacer(),
          AppButton(
            text: AppString.continueText,
            onTap: widget.onTapContinue,
          ),
        ],
      ),
    );
  }
}
