import 'package:flutter/material.dart';
import 'package:ostad/constant/app_dimens.dart';
import 'package:ostad/constant/app_string.dart';
import 'package:ostad/widgets/bullet_text.dart';
import 'package:ostad/widgets/app_button.dart';
import 'package:ostad/widgets/app_text_field.dart';

class EnterEmailStep extends StatefulWidget {
  const EnterEmailStep({
    super.key,
    required this.onTapContinue,
  });

  final void Function(String email) onTapContinue;

  @override
  State<EnterEmailStep> createState() => _EnterEmailStepState();
}

class _EnterEmailStepState extends State<EnterEmailStep> {
  late final TextEditingController _email;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          AppDimens.vSpaceExtraLarge,
          AppTextFormField.withTitle(
            title: AppString.email,
            controller: _email,
            validationType: ValidationType.email,
            hintText: AppString.emailHint,
          ),
          AppDimens.vSpaceSmall,
          BulletText(
            text: AppString.enterYourEmailForVerification,
          ),
          const Spacer(),
          AppButton(
            text: AppString.continueText,
            onTap: () {
              widget.onTapContinue(_email.text);
            },
          ),
        ],
      ),
    );
  }
}
