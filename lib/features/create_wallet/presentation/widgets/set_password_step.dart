import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_message.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/route/app_route_name.dart';
import 'package:ostad/core/widgets/app_button.dart';
import 'package:ostad/core/widgets/app_text_field.dart';
import 'package:ostad/core/widgets/app_snack_bar.dart';
import 'package:ostad/features/create_wallet/presentation/provider/create_wallet_provider.dart';
import 'package:provider/provider.dart';

class SetPasswordStep extends StatefulWidget {
  const SetPasswordStep({super.key});

  @override
  State<SetPasswordStep> createState() => _SetPasswordStepState();
}

class _SetPasswordStepState extends State<SetPasswordStep> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final createWalletProvider = Provider.of<CreateWalletProvider>(context);

    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // image
                  SvgPicture.asset(
                    AppImages.createWalletSetPassword,
                    height: 200.r,
                    width: 200.r,
                    fit: BoxFit.contain,
                  ),
                  AppDimens.vSpaceMedium,
                  // password field
                  AppTextFormField.withTitle(
                    controller: createWalletProvider.passwordController,
                    title: AppString.newPassword,
                    hintText: AppString.enterPassword,
                    validationType: ValidationType.password,
                    textInputAction: TextInputAction.next,
                  ),
                  AppDimens.vSpaceMedium,
                  // repeat Password field
                  AppTextFormField.withTitle(
                    controller: createWalletProvider.repeatPasswordController,
                    title: AppString.newRepeatPassword,
                    hintText: AppString.enterRepeatPassword,
                    validationType: ValidationType.repeatPassword,
                  ),
                  AppDimens.vSpaceVeryLarge,
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.paddingSmall,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppString.enterWithFingerPrint,
                            style: theme.textTheme.bodyMedium,
                          ),
                          Switch(
                            value: createWalletProvider.enterWithFingerPrint,
                            onChanged: (value) {
                              createWalletProvider.updateEnterWithFingerPrint(value);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  AppDimens.vSpaceLarge,
                  Spacer(),
                  // continu button
                  Consumer<CreateWalletProvider>(
                    builder: (context, createWalletProvider, child) {
                      if (createWalletProvider.state == CreateWalletState.error) {
                        Future.microtask(
                          () {
                            AppSnackBar.showError(context,
                                message: createWalletProvider.errorMessage ?? '');
                          },
                        );
                      }
                      return AppButton(
                        text: AppString.continueText,
                        isLoading: createWalletProvider.state == CreateWalletState.settingPassword,
                        onTap: () {
                          createWalletProvider.updateIsPasswordMatch();
                          if (_formKey.currentState!.validate() &&
                              createWalletProvider.isPasswordMatch) {
                            createWalletProvider.setPassword().then(
                              (value) {
                                if (createWalletProvider.state == CreateWalletState.success) {
                                  GoRouter.of(context).go(AppRouteName.recoveryphrase);
                                }
                              },
                            );
                          } else {
                            Future.microtask(
                              () {
                                AppSnackBar.showError(context,
                                    message: AppMessage.passwordNotMatch);
                              },
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
