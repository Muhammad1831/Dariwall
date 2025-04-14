import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/route/app_route_name.dart';
import 'package:ostad/core/widgets/app_button.dart';
import 'package:ostad/core/widgets/app_glow_dot.dart';
import 'package:ostad/core/widgets/app_gradiant_text.dart';
import 'package:ostad/core/widgets/app_header.dart';
import 'package:ostad/core/widgets/app_text_field.dart';
import 'package:ostad/features/create_new_wallet/presentation/provider/create_wallet_provider.dart';
import 'package:provider/provider.dart';

class CreateNewWalletPage extends StatefulWidget {
  const CreateNewWalletPage({super.key});

  @override
  State<CreateNewWalletPage> createState() => _CreateNewWalletPageState();
}

class _CreateNewWalletPageState extends State<CreateNewWalletPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(AppDimens.paddingLarge),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AppGlowDot(
                  shadow: AppColor.pinkGlowShadow,
                  bottom: 0,
                  left: 0,
                ),
                AppGlowDot(shadow: AppColor.blueGlowShadow),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppHeader(headerText: AppString.createNewWallet),
                    AppDimens.vSpaceVeryLarge,
                    // image
                    SvgPicture.asset(
                      AppImages.createNewWallet,
                      fit: BoxFit.scaleDown,
                    ),
                    AppDimens.vSpaceMedium,
                    // phone number field
                    AppTextFormField.withTitle(
                      controller: TextEditingController(),
                      title: AppString.userName,
                      hintText: AppString.enterUserName,
                      validationType: ValidationType.notEmpty,
                      errorText: AppString.userNameCanNotBeEmpty,
                    ),
                    AppDimens.vSpaceMedium,
                    // referrerCode field
                    AppTextFormField.withTitle(
                      controller: TextEditingController(),
                      title: '${AppString.referrerCode}(${AppString.optional})',
                      hintText: AppString.enterReferrerCode,
                      validator: null,
                    ),
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
                              text: AppString.roleAndCondition,
                              style: theme.textTheme.bodySmall!.copyWith(
                                color: AppColor.infoColor,
                              ),
                              children: [
                                TextSpan(
                                  text: ' ${AppString.useOf}',
                                  style: theme.textTheme.bodySmall,
                                ),
                                WidgetSpan(
                                  child: AppGradiantText(
                                    ' ${AppString.dariWall}',
                                    gradient: AppColor.logoGradient,
                                  ),
                                ),
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
                    AppButton(
                      text: AppString.continueText,
                      bgColor: theme.disabledColor,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.goNamed(AppRouteName.recoveryphrase);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
