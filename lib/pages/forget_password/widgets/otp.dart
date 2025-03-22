import 'package:flutter/material.dart';
import 'package:ostad/constant/app_dimens.dart';
import 'package:ostad/constant/app_string.dart';
import 'package:ostad/widgets/bullet_text.dart';
import 'package:ostad/widgets/app_button.dart';
import 'package:ostad/widgets/app_text_field.dart';

class OtpStep extends StatefulWidget {
  const OtpStep({
    super.key,
    required this.onTapContinue,
    required this.onTapResend,
    required this.email,
  });

  final VoidCallback onTapContinue;
  final VoidCallback onTapResend;
  final String email;

  @override
  State<OtpStep> createState() => _OtpStepState();
}

class _OtpStepState extends State<OtpStep> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1) {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    } else if (value.isEmpty && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppDimens.vSpaceExtraLarge,
          Text(
            AppString.completValidationProcess,
            style: theme.textTheme.titleMedium,
          ),
          AppDimens.vSpaceSmall,
          BulletText(
            text: AppString.checkYourEmail,
          ),
          AppDimens.vSpaceSmall,
          Align(
            alignment: Alignment.center,
            child: Text(
              AppString.codeSentToEmail(widget.email),
              style: theme.textTheme.bodySmall,
            ),
          ),
          AppDimens.vSpaceLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              6,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: AppTextFormField(
                    controller: _controllers[5 - index],
                    focusNode: _focusNodes[5 - index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: theme.textTheme.headlineMedium,
                    onChanged: (value) {
                      _onChanged(value, 5 - index);
                    },
                  ),
                ),
              ),
            ).toList().reversed.toList(),
          ),
          AppDimens.vSpaceLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.codeNotSent,
                style: theme.textTheme.bodySmall,
              ),
              AppDimens.hSpaceVerySmall,
              GestureDetector(
                onTap: widget.onTapResend,
                child: Text(
                  AppString.sentCodeAgain,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          AppButton(
            text: AppString.continueText,
            onTap: () {
              final otp = _controllers.map((c) => c.text).join();
              if (otp.length == 6) {
                widget.onTapContinue();
              }
            },
          ),
        ],
      ),
    );
  }
}
