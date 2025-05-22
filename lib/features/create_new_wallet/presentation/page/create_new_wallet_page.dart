import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_gradiant_text.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_text_field.dart';
import 'package:dariwall/features/create_new_wallet/presentation/provider/create_wallet_provider.dart';
import 'package:provider/provider.dart';

class CreateNewWalletPage extends StatefulWidget {
  const CreateNewWalletPage({super.key});

  @override
  State<CreateNewWalletPage> createState() => _CreateNewWalletPageState();
}

class _CreateNewWalletPageState extends State<CreateNewWalletPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();
  bool _isAcceptTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _referralCodeController.dispose();
    super.dispose();
  }

  void _updateAcceptTerms(bool value) {
    setState(() {
      _isAcceptTerms = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(AppDimens.paddingLarge),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppHeader(headerText: AppString.createNewWallet),
                AppDimens.vSpaceVeryLarge,
                // image
                Image.asset(
                  height: size.height * 0.3,
                  width: size.height * 0.25,
                  AppImages.createNewWallet,
                  fit: BoxFit.cover,
                ),
                AppDimens.vSpaceMedium,
                // phone number field
                AppTextFormField.withTitle(
                  controller: _nameController,
                  title: AppString.userName,
                  hintText: AppString.enterUserName,
                  validationType: ValidationType.notEmpty,
                  errorText: AppString.userNameCanNotBeEmpty,
                ),
                AppDimens.vSpaceMedium,
                // referrerCode field
                AppTextFormField.withTitle(
                  controller: _referralCodeController,
                  title: '${AppString.referrerCode}(${AppString.optional})',
                  hintText: AppString.enterReferrerCode,
                  validator: null,
                ),
                Spacer(),
                // check box
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: _isAcceptTerms,
                      onChanged: (value) {
                        _updateAcceptTerms(value ?? false);
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
                Consumer<CreateWalletProvider>(
                  builder: (context, provider, child) {
                    return AppButton(
                      isLoading: provider.status == CreateWalletStatus.loading,
                      text: AppString.continueText,
                      bgColor: _isAcceptTerms ? theme.primaryColor : theme.disabledColor,
                      onTap: () async {
                        if (_formKey.currentState!.validate() && _isAcceptTerms) {
                          await provider.createWallet(
                            _nameController.text,
                            _referralCodeController.text.isEmpty
                                ? null
                                : _referralCodeController.text,
                          );
                          if (provider.status == CreateWalletStatus.success) {
                            context.goNamed(AppRouteName.recoveryphrase);
                          }
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
