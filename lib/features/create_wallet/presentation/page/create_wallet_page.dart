import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/widgets/app_back_button.dart';
import 'package:ostad/core/widgets/app_progress_bar.dart';
import 'package:ostad/features/create_wallet/presentation/provider/create_wallet_provider.dart';
import 'package:ostad/features/create_wallet/presentation/widgets/basic_information_step.dart';
import 'package:ostad/features/create_wallet/presentation/widgets/set_password_step.dart';
import 'package:ostad/features/create_wallet/presentation/widgets/validation_step.dart';
import 'package:provider/provider.dart';

List<String> stepsTitle = [
  AppString.basicInfo,
  AppString.validation,
  AppString.password,
];

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({super.key});

  @override
  State<CreateWalletPage> createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {
  @override
  Widget build(BuildContext context) {
    final createWalletProvider = Provider.of<CreateWalletProvider>(context, listen: false);

    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(AppDimens.paddingLarge),
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppBackButton(
                      icon: CupertinoIcons.chevron_forward,
                      onTap: () {
                        if (createWalletProvider.currentStepIndex == CreateWalletStep.basicInfo) {
                          context.pop();
                        } else {
                          Future.microtask(() {
                            createWalletProvider.previousStep();
                          });
                        }
                      },
                    ),
                  ),
                  AppDimens.vSpaceMedium,
                  Consumer<CreateWalletProvider>(
                    builder: (context, createWalletProvider, child) {
                      return AppProgressBar(
                        stepsTitle: stepsTitle,
                        activeColor: theme.colorScheme.tertiary,
                        inactiveColor: theme.colorScheme.surface,
                        currentStepIndex: createWalletProvider.currentStepIndex.index,
                      );
                    },
                  ),
                ],
              ),
              AppDimens.vSpaceVeryLarge,
              Consumer<CreateWalletProvider>(
                builder: (context, createWalletProvider, child) {
                  if (createWalletProvider.currentStepIndex == CreateWalletStep.validation) {
                    return ValidationStep();
                  } else if (createWalletProvider.currentStepIndex == CreateWalletStep.password) {
                    return SetPasswordStep();
                  } else {
                    return BasicInformationStep();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
