import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_text_field.dart';
import 'package:dariwall/features/login/presentation/provider/login_provider.dart';
import 'package:provider/provider.dart';

class LoginWithEmailPage extends StatefulWidget {
  const LoginWithEmailPage({super.key});

  @override
  State<LoginWithEmailPage> createState() => _LoginWithEmailPageState();
}

class _LoginWithEmailPageState extends State<LoginWithEmailPage> {
  late final TextEditingController emailController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(AppDimens.paddingLarge),
                  child: Center(
                    child: Column(
                      children: [
                        AppHeader(
                          headerText: AppString.enterToWallet,
                        ),
                        AppDimens.vSpaceExtraLarge,
                        SvgPicture.asset(
                          AppImages.connectWalletToEmail,
                          fit: BoxFit.scaleDown,
                        ),
                        AppDimens.vSpaceLarge,
                        AppTextFormField.withTitle(
                          title: AppString.email,
                          controller: emailController,
                          hintText: AppString.enterEmail,
                          validationType: ValidationType.email,
                        ),
                        AppDimens.vSpaceLarge,
                        Spacer(),
                        Consumer<LoginProvider>(
                          builder: (context, provider, child) {
                            return AppButton(
                              isLoading: provider.status == LoginStatus.loading,
                              text: AppString.continueText,
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await provider.loginWithEmail(email: emailController.text);
                                  if (provider.status == LoginStatus.success) {
                                    context.pushNamed(
                                      AppRouteName.validation,
                                      extra: emailController.text,
                                    );
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
            )
          ],
        ),
      ),
    );
  }
}
