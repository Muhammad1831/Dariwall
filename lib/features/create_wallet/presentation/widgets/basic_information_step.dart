import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/widgets/app_button.dart';
import 'package:ostad/core/widgets/app_snack_bar.dart';
import 'package:ostad/core/widgets/app_text_field.dart';
import 'package:ostad/features/create_wallet/presentation/provider/create_wallet_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BasicInformationStep extends StatelessWidget {
  BasicInformationStep({
    super.key,
  });
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final createWalletProvider = Provider.of<CreateWalletProvider>(context, listen: false);

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
                    AppImages.createWalletBasicInfo,
                    height: 200.r,
                    width: 200.r,
                    fit: BoxFit.contain,
                  ),
                  AppDimens.vSpaceMedium,
                  // phone number field
                  AppTextFormField.withTitle(
                    controller: createWalletProvider.phoneNumberController,
                    title: AppString.phoneNumber,
                    hintText: AppString.enterPhoneNumber,
                    validationType: ValidationType.phoneNumber,
                  ),
                  AppDimens.vSpaceMedium,
                  // referrerCode field
                  AppTextFormField.withTitle(
                    controller: createWalletProvider.referrerCodeController,
                    title: '${AppString.referrerCode}(${AppString.optional})',
                    hintText: AppString.enterReferrerCode,
                    validator: null,
                  ),
                  AppDimens.vSpaceVeryLarge,
                  Spacer(),
                  // check box
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Consumer<CreateWalletProvider>(
                        builder: (context, createWalletProvider, child) {
                          return Checkbox(
                            value: createWalletProvider.isAcceptTerms,
                            onChanged: (value) {
                              createWalletProvider.updateAcceptTerms(value ?? false);
                            },
                          );
                        },
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: AppString.roleOfUseDariwall,
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: AppColor.infoColor,
                            ),
                            children: [
                              TextSpan(
                                text: ' ${AppString.accept}',
                                style: theme.textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppDimens.vSpaceVeryVerySmall,
                  // continu button
                  Consumer<CreateWalletProvider>(
                    builder: (context, createWalletProvider, child) {
                      if (createWalletProvider.state == CreateWalletState.error) {
                        Future.microtask(() {
                          AppSnackBar.showError(
                            context,
                            message: createWalletProvider.errorMessage ?? '',
                          );
                        });
                      }
                      return AppButton(
                        text: AppString.continueText,
                        bgColor: createWalletProvider.isAcceptTerms ? null : theme.disabledColor,
                        isLoading: createWalletProvider.state == CreateWalletState.gettingOtp,
                        onTap: () {
                          if (_formKey.currentState!.validate() &&
                              createWalletProvider.isAcceptTerms) {
                            createWalletProvider.sendPhoneNumberAndReferralCode().then(
                              (value) {
                                if (createWalletProvider.state == CreateWalletState.success) {
                                  Future.microtask(
                                    () {
                                      createWalletProvider.nextStep();
                                    },
                                  );
                                }
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
