import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ostad/constant/app_color.dart';
import 'package:ostad/constant/app_dimens.dart';
import 'package:ostad/constant/app_images.dart';
import 'package:ostad/constant/app_string.dart';
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
                    style: theme.headlineSmall,
                  ),
                  AppDimens.vSpaceExtraLarge,
                  // phone number title
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppString.phoneNumber,
                      style: theme.titleSmall,
                    ),
                  ),
                  AppDimens.vSpaceVerySmall,
                  // phone number input field
                  AppTextFormField(
                    controller: phoneNumber,
                    hintText: AppString.phoneHint,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validationType: ValidationType.phoneNumber,
                    suffixIcon: Icon(Icons.person_outline_rounded),
                  ),
                  AppDimens.vSpaceMedium,
                  // password title
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppString.password,
                      style: theme.titleSmall,
                    ),
                  ),
                  AppDimens.vSpaceVerySmall,
                  // password input field
                  AppTextFormField(
                    controller: password,
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
                      //TODO: add forgot password page
                      onTap: () {},
                      child: Text(
                        AppString.forgotPassword,
                        style: theme.bodySmall!.copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  AppDimens.vSpaceVeryLarge,
                  // login button
                  AppButton(
                    //TODO: add login page
                    onTap: () {},
                    text: AppString.enterInAccount,
                  ),
                  SizedBox(height: 100.h),
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
                        //TODO: create account
                        onTap: () {},
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
