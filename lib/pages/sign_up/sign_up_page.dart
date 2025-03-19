import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ostad/constant/app_color.dart';
import 'package:ostad/constant/app_dimens.dart';
import 'package:ostad/constant/app_images.dart';
import 'package:ostad/constant/app_string.dart';
import 'package:ostad/providers/image_picker_provider.dart';
import 'package:ostad/widgets/app_button.dart';
import 'package:ostad/widgets/app_header.dart';
import 'package:ostad/widgets/app_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';

enum Sex { none, male, female }

enum Step {
  information,
  referrer,
  validation,
  otp,
  password,
  upload,
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Step currentStep = Step.information;
  String _email = '';

  void nextStep() {
    setState(() {
      if (currentStep.index < Step.values.length - 1) {
        currentStep = Step.values[currentStep.index + 1];
      }
    });
  }

  void previousStep() {
    setState(() {
      if (currentStep.index > 0) {
        currentStep = Step.values[currentStep.index - 1];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: currentStep == Step.information,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.paddingLarge,
            vertical: AppDimens.paddingVeryLarge,
          ),
          child: Column(
            children: [
              AppHeader(
                headerText: AppString.createUserAccount,
                onTap: () {
                  if (Step.information == currentStep) {
                    GoRouter.of(context).pop();
                  } else {
                    previousStep();
                  }
                },
              ),
              AppDimens.vSpaceVeryLarge,
              // progress bar
              Row(
                children: [
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: currentStep.index >= Step.values[Step.information.index].index
                            ? theme.colorScheme.tertiary
                            : theme.colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 2,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: currentStep.index >= Step.values[Step.referrer.index].index
                              ? theme.colorScheme.tertiary
                              : theme.colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: currentStep.index >= Step.values[Step.referrer.index].index
                            ? theme.colorScheme.tertiary
                            : theme.colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 2,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: currentStep.index >= Step.values[Step.validation.index].index
                              ? theme.colorScheme.tertiary
                              : theme.colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: currentStep.index >= Step.values[Step.validation.index].index
                            ? theme.colorScheme.tertiary
                            : theme.colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 2,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: currentStep.index >= Step.values[Step.password.index].index
                              ? theme.colorScheme.tertiary
                              : theme.colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: currentStep.index >= Step.values[Step.password.index].index
                            ? theme.colorScheme.tertiary
                            : theme.colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 2,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: currentStep.index >= Step.values[Step.upload.index].index
                              ? theme.colorScheme.tertiary
                              : theme.colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: currentStep.index >= Step.values[Step.upload.index].index
                            ? theme.colorScheme.tertiary
                            : theme.colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              AppDimens.vSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.info,
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    AppString.referrer,
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    AppString.validation,
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    AppString.password,
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    AppString.upload,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              AppDimens.vSpaceMedium,
              if (currentStep == Step.information)
                InformationStep(
                  onTapContinue: nextStep,
                ),
              if (currentStep == Step.referrer)
                ReferrerStep(
                  onTapContinue: nextStep,
                  onTapDontHaveReferrer: nextStep,
                ),
              if (currentStep == Step.validation)
                ValidationStep(
                  onTapContinue: (email) {
                    _email = email;
                    nextStep();
                  },
                ),
              if (currentStep == Step.otp)
                OtpStep(
                  email: _email,
                  onTapContinue: nextStep,
                  onTapResend: () {
                    // handle resend logic
                  },
                ),
              if (currentStep == Step.password)
                PasswordStep(
                  onTapContinue: nextStep,
                ),
              if (currentStep == Step.upload)
                ChangeNotifierProvider(
                  create: (context) => ImagePickerProvider(),
                  child: UploadStep(
                    onTapConfirm: () {},
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class InformationStep extends StatefulWidget {
  const InformationStep({
    super.key,
    required this.onTapContinue,
  });

  final VoidCallback onTapContinue;

  @override
  State<InformationStep> createState() => _InformationStepState();
}

class _InformationStepState extends State<InformationStep> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _studentNumber = TextEditingController();
  final TextEditingController _telegramId = TextEditingController();
  final TextEditingController _solanaAddressWallet = TextEditingController();

  Sex sex = Sex.none;

  void onSexChanged(Sex value) {
    setState(() {
      sex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDimens.vSpaceVeryLarge,
            // basic Information title
            CustomTitle(title: AppString.basicInfo),
            AppDimens.vSpaceVerySmall,
            // name textformfield
            AppTextFormField.withTitle(
              controller: _name,
              title: AppString.name,
              hintText: AppString.enterYourName,
              textInputAction: TextInputAction.next,
              validationType: ValidationType.notEmpty,
            ),
            AppDimens.vSpaceMedium,
            // last name textformfield
            AppTextFormField.withTitle(
              controller: _lastName,
              title: AppString.lastName,
              hintText: AppString.enterYourLastName,
              validationType: ValidationType.notEmpty,
            ),
            AppDimens.vSpaceMedium,
            // sex title
            Text(AppString.sex, style: theme.textTheme.titleSmall),
            AppDimens.vSpaceVeryVerySmall,
            // sex button
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: AppString.male,
                    onTap: () => onSexChanged(Sex.male),
                    bgColor:
                        sex == Sex.male ? theme.colorScheme.tertiary : theme.colorScheme.surface,
                    borderRadius: AppDimens.borderRadiusExtraLarge,
                    textColor: sex == Sex.male ? theme.colorScheme.surfaceContainerHighest : null,
                  ),
                ),
                AppDimens.hSpaceVerySmall,
                Expanded(
                  child: AppButton(
                    text: AppString.female,
                    onTap: () => onSexChanged(Sex.female),
                    bgColor:
                        sex == Sex.female ? theme.colorScheme.tertiary : theme.colorScheme.surface,
                    borderRadius: AppDimens.borderRadiusExtraLarge,
                    textColor: sex == Sex.female ? theme.colorScheme.surfaceContainerHighest : null,
                  ),
                ),
              ],
            ),
            AppDimens.vSpaceVeryLarge,
            // additional info title
            CustomTitle(title: AppString.additionalInfo),
            AppDimens.vSpaceMedium,
            // student number textformfield
            AppTextFormField.withTitle(
              controller: _studentNumber,
              title: AppString.studentNumber,
              hintText: AppString.enterStudentNumber,
              validationType: ValidationType.notEmpty,
            ),
            AppDimens.vSpaceMedium,
            // telegram id textformfield
            AppTextFormField.withTitle(
              controller: _telegramId,
              title: AppString.telegramId,
              hintText: AppString.enterTelegramId,
              validationType: ValidationType.notEmpty,
            ),
            AppDimens.vSpaceMedium,
            // solana address wallet textformfield
            AppTextFormField.withTitle(
              controller: _solanaAddressWallet,
              title: AppString.solanaAddressWallet,
              hintText: AppString.enterSolanaAddressWallet,
              validationType: ValidationType.notEmpty,
            ),
            AppDimens.vSpaceVerySmall,
            BulletText(
              text: AppString.mustUsePhantomWallet,
            ),
            AppDimens.vSpaceVeryLarge,
            AppButton(
              text: AppString.continueText,
              onTap: widget.onTapContinue,
            )
          ],
        ),
      ),
    );
  }
}

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 4.r,
          height: 4.r,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              shape: BoxShape.circle,
            ),
          ),
        ),
        AppDimens.hSpaceSmall,
        Text(
          AppString.basicInfo,
          style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
        AppDimens.hSpaceSmall,
        SizedBox(
          width: 4.r,
          height: 4.r,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

class BulletText extends StatelessWidget {
  const BulletText({
    super.key,
    required this.text,
    this.bulletColor,
    this.textStyle,
  });

  final String text;
  final Color? bulletColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 4.r,
          width: 4.r,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: bulletColor ?? theme.colorScheme.outline,
              shape: BoxShape.circle,
            ),
          ),
        ),
        AppDimens.hSpaceVerySmall,
        Expanded(
          child: Text(
            text,
            style: textStyle ?? theme.textTheme.labelSmall,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}

class ValidationStep extends StatefulWidget {
  const ValidationStep({
    super.key,
    required this.onTapContinue,
  });

  final void Function(String email) onTapContinue;

  @override
  State<ValidationStep> createState() => _ValidationStepState();
}

class _ValidationStepState extends State<ValidationStep> {
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

class ReferrerStep extends StatefulWidget {
  const ReferrerStep({
    super.key,
    required this.onTapContinue,
    required this.onTapDontHaveReferrer,
  });

  final VoidCallback onTapContinue;
  final VoidCallback onTapDontHaveReferrer;

  @override
  State<ReferrerStep> createState() => _ReferrerStepState();
}

class _ReferrerStepState extends State<ReferrerStep> {
  late final TextEditingController _referrerPhoneNumber;

  @override
  void initState() {
    super.initState();
    _referrerPhoneNumber = TextEditingController();
  }

  @override
  void dispose() {
    _referrerPhoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppDimens.vSpaceExtraLarge,
              AppTextFormField.withTitle(
                title: AppString.referrerPhoneNumber,
                controller: _referrerPhoneNumber,
                hintText: AppString.referrerHintText,
                keyboardType: TextInputType.number,
                maxLength: 11,
              ),
              AppDimens.vSpaceSmall,
              BulletText(text: AppString.referrerOptionalText1),
              AppDimens.vSpaceVerySmall,
              BulletText(text: AppString.referrerOptionalText2),
            ],
          ),
          Column(
            children: [
              AppButton(
                text: AppString.continueText,
                onTap: widget.onTapContinue,
              ),
              AppDimens.vSpaceMedium,
              AppButton(
                text: AppString.dontHaveReferrer,
                onTap: widget.onTapDontHaveReferrer,
                bgColor: Colors.transparent,
                textColor: theme.colorScheme.tertiary,
                borderColor: theme.colorScheme.tertiary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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

class UploadStep extends StatefulWidget {
  const UploadStep({
    super.key,
    required this.onTapConfirm,
  });

  final VoidCallback onTapConfirm;

  @override
  State<UploadStep> createState() => _UploadStepState();
}

class _UploadStepState extends State<UploadStep> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Consumer<ImagePickerProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppDimens.vSpaceExtraLarge,
              InkWell(
                onTap: () {
                  context.read<ImagePickerProvider>().pickImage(
                        source: ImageSource.gallery,
                      );
                },
                borderRadius: BorderRadius.circular(AppDimens.borderRadiusMedium),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(AppDimens.borderRadiusMedium),
                  color: theme.colorScheme.outline,
                  strokeWidth: 0.5,
                  dashPattern: const [4, 4],
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimens.veryLarge,
                    horizontal: AppDimens.large,
                  ),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        provider.image != null
                            ? SizedBox(
                                height: 160.r,
                                child: Image.file(
                                  File(
                                    provider.image!.path,
                                  ),
                                  fit: BoxFit.scaleDown,
                                ),
                              )
                            : Image.asset(
                                AppImages.card,
                                fit: BoxFit.scaleDown,
                              ),
                        AppDimens.vSpaceLarge,
                        provider.image == null
                            ? Text(
                                AppString.noDocumentUploaded,
                                style: theme.textTheme.titleMedium,
                              )
                            : Row(
                                spacing: AppDimens.veryVerySmall,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: AppColor.successColor,
                                  ),
                                  Text(
                                    AppString.imageUploadedSuccessfuly,
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: AppColor.successColor),
                                  )
                                ],
                              ),
                        AppDimens.vSpaceMedium,
                        provider.image == null
                            ? Text(
                                AppString.uploadImage,
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: theme.colorScheme.tertiary,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                AppString.uploadNewImage,
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: theme.colorScheme.tertiary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              AppButton(
                text: AppString.confirm,
                onTap: widget.onTapConfirm,
                bgColor: provider.image != null ? null : theme.cardTheme.color,
              ),
            ],
          );
        },
      ),
    );
  }
}

class PasswordStep extends StatefulWidget {
  const PasswordStep({
    super.key,
    required this.onTapContinue,
  });

  final VoidCallback onTapContinue;

  @override
  State<PasswordStep> createState() => _PasswordStepState();
}

class _PasswordStepState extends State<PasswordStep> {
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
            title: AppString.password,
            validationType: ValidationType.password,
          ),
          AppDimens.vSpaceMedium,
          AppTextFormField(
            controller: _repeatPassword,
            hintText: AppString.enterRepeatPassword,
            obscureText: true,
            title: AppString.repeatPassword,
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
