import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_text_field.dart';
import 'package:dariwall/features/connet_wallet_to_email/presentation/providers/connect_wallet_email_provider.dart';
import 'package:provider/provider.dart';

class ConnetWalletToEmailPage extends StatefulWidget {
  const ConnetWalletToEmailPage({super.key});

  @override
  State<ConnetWalletToEmailPage> createState() => _ConnetWalletToEmailPageState();
}

class _ConnetWalletToEmailPageState extends State<ConnetWalletToEmailPage> {
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
    return ChangeNotifierProvider.value(
      value: getIt<ConnectWalletEmailProvider>(),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.all(AppDimens.paddingLarge),
              child: Center(
                child: Column(
                  children: [
                    AppHeader(
                      headerText: AppString.connectWalletToEmail,
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
                    Spacer(),
                    Consumer<ConnectWalletEmailProvider>(
                      builder: (context, provider, child) {
                        return AppButton(
                          text: AppString.sendCode,
                          isLoading: provider.status == ConnectWalletEmailStatus.loading,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await provider.sendEmailOtp(email: emailController.text);
                              if (provider.status == ConnectWalletEmailStatus.success) {
                                context.pushNamed(
                                  AppRouteName.connectWalletEmailOtp,
                                  extra: emailController.text,
                                );
                              }
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
