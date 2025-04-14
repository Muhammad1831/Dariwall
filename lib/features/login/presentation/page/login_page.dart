import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/features/login/presentation/provider/auth_provider.dart';
import 'package:ostad/core/route/app_route_name.dart';
import 'package:ostad/core/widgets/app_button.dart';
import 'package:ostad/core/widgets/app_text_field.dart';
import 'package:provider/provider.dart';
import 'package:ostad/core/widgets/app_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool obscureText = true;

  void _togglePasswordVisibility() {
    setState(() => obscureText = !obscureText);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.paddingLarge,
                vertical: AppDimens.paddingVeryLarge,
              ),
              child: Column(
                children: [
                  AppDimens.vSpaceSmall,
                  // logo image
                  Image.asset(
                    AppImages.logo,
                    width: 80,
                    height: 80,
                  ),
                  AppDimens.vSpaceVerySmall,
                  // ostad text
                  Text(
                    AppString.dariWall,
                    style: theme.textTheme.displayMedium,
                  ),
                  AppDimens.vSpaceLarge,
                  // enter user account text
                  Text(
                    AppString.enterToWallet,
                    style: theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  AppDimens.vSpaceExtraLarge,
                  // phone number input field
                  AppTextFormField.withTitle(
                    controller: phoneNumber,
                    title: AppString.phoneNumber,
                    hintText: AppString.phoneHint,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validationType: ValidationType.phoneNumber,
                    suffixIcon: Icon(Icons.person_outline_rounded),
                  ),
                  AppDimens.vSpaceMedium,
                  // password input field
                  AppTextFormField.withTitle(
                    controller: password,
                    title: AppString.password,
                    hintText: AppString.passHint,
                    validationType: ValidationType.password,
                    obscureText: obscureText,
                    suffixIcon: GestureDetector(
                      onTap: () => _togglePasswordVisibility(),
                      child: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  AppDimens.vSpaceVerySmall,
                  // forgot password text
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRouteName.forgetPassword);
                      },
                      child: Text(
                        AppString.forgotPassword,
                        style: theme.textTheme.bodySmall!
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  AppDimens.vSpaceVeryLarge,
                  // login button
                  Consumer<AuthProvider>(
                    builder: (context, provider, child) {
                      return AppButton(
                        isLoading: provider.status == AuthStatus.loading,
                        onTap: () async {
                          await provider.login(
                            phoneNumber: phoneNumber.text,
                            password: password.text,
                          );
                          if (provider.status == AuthStatus.authenticated) {
                            context.goNamed(AppRouteName.home);
                          } else {
                            AppSnackBar.showError(
                              context,
                              message: provider.errorMessage!,
                            );
                          }
                        },
                        text: AppString.enterToWallet,
                      );
                    },
                  ),
                  AppDimens.vSpaceSmall,
                  AppButton(
                    text: AppString.enterWithRecoveryPharse,
                    onTap: () {},
                    bgColor: theme.scaffoldBackgroundColor,
                    borderColor: theme.colorScheme.onSurface,
                    textColor: theme.colorScheme.onSurface,
                  ),
                  SizedBox(height: 100),
                  // dont have wallet text and create wallet button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppString.dontHaveWallet,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: AppColor.textSecondary1Color),
                      ),
                      AppDimens.hSpaceVerySmall,
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRouteName.createNewWallet);
                        },
                        child: Text(
                          AppString.createNewWallet,
                          style: theme.textTheme.bodyMedium!.copyWith(color: AppColor.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
