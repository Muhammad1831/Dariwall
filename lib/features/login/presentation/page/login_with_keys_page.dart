import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/utils/utils_show_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_text_field.dart';
import 'package:dariwall/features/login/presentation/provider/login_provider.dart';

class LoginWithKeysPage extends StatefulWidget {
  const LoginWithKeysPage({super.key});

  @override
  State<LoginWithKeysPage> createState() => _LoginWithKeysPageState();
}

class _LoginWithKeysPageState extends State<LoginWithKeysPage> {
  final List<TextEditingController> _controllers = List.generate(
    12,
    (index) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppDimens.paddingLarge),
            child: Column(
              children: [
                AppHeader(headerText: AppString.enterToWallet),
                AppDimens.vSpaceVeryLarge,
                Text(
                  AppString.loginWithKeysDescription,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppDimens.vSpaceVeryLarge,
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppDimens.verySmall,
                    crossAxisSpacing: AppDimens.verySmall,
                    childAspectRatio: 3,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return AppTextFormField(
                      controller: _controllers[index],
                      textInputAction: TextInputAction.next,
                      borderRadius: AppDimens.borderRadiusMedium,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
                        child: Text('${index + 1}'),
                      ),
                      maxLength: 10,
                    );
                  },
                ),
                AppDimens.vSpaceVeryLarge,
                Consumer<LoginProvider>(
                  builder: (context, provider, child) {
                    return AppButton(
                      isLoading: provider.status == LoginStatus.loading,
                      text: AppString.enterToApp,
                      onTap: () async {
                        if (_controllers.every((controller) => controller.text.isNotEmpty)) {
                          final values = _controllers.map((controller) => controller.text).toList();
                          await provider.loginWithKeys(keys: values).then(
                            (value) {
                              if (provider.status == LoginStatus.loggedIn) {
                                context.pushReplacementNamed(AppRouteName.home);
                              }
                            },
                          );
                        } else {
                          UtilsShowSnackbar.show(
                            context: context,
                            status: Status.warning,
                            message: AppMessage.allFieldsAreRequired,
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
      ),
    );
  }
}
