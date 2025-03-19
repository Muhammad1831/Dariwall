import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/constant/app_color.dart';
import 'package:ostad/constant/app_dimens.dart';
import 'package:ostad/constant/app_images.dart';
import 'package:ostad/constant/app_string.dart';
import 'package:ostad/route/app_route_name.dart';
import 'package:ostad/widgets/app_button.dart';
import 'package:ostad/widgets/app_text_field.dart';

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
    final theme = Theme.of(context).textTheme;
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
                    width: 80.h,
                    height: 80.h,
                  ),
                  AppDimens.vSpaceVerySmall,
                  // ostad text
                  Text(
                    AppString.ostad,
                    style: theme.displayMedium,
                  ),
                  AppDimens.vSpaceLarge,
                  // enter user account text
                  Text(
                    AppString.enterUserAccount,
                    style: theme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
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
                        GoRouter.of(context).push(AppRouteName.forgetPassword);
                      },
                      child: Text(
                        AppString.forgotPassword,
                        style: theme.bodySmall!.copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  AppDimens.vSpaceVeryLarge,
                  // login button
                  AppButton(
                    onTap: () {
                      GoRouter.of(context).go(AppRouteName.home);
                    },
                    text: AppString.enterInAccount,
                  ),
                  SizedBox(height: 100.r),
                  // dont have account text and create account button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppString.dontHaveAccount,
                        style: theme.bodySmall!.copyWith(color: AppColor.textSecondary1Color),
                      ),
                      AppDimens.hSpaceVerySmall,
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push(AppRouteName.signUp);
                        },
                        child: Text(
                          AppString.createAccount,
                          style: theme.bodyMedium!.copyWith(color: AppColor.primaryColor),
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
