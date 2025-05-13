import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_text_field.dart';
import 'package:dariwall/features/solana_address_wallet/presentation/provider/solana_address_wallet_provider.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';
import 'package:provider/provider.dart';

class SolanaAddressWalletPage extends StatefulWidget {
  const SolanaAddressWalletPage({super.key});

  @override
  State<SolanaAddressWalletPage> createState() => _SolanaAddressWalletPageState();
}

class _SolanaAddressWalletPageState extends State<SolanaAddressWalletPage> {
  final TextEditingController solanaAddressWalletController = TextEditingController();
  String? solanaAddressWallet;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<GetUserAccountInfoProvider>(context, listen: false);
    if (provider.userAccountInfo?.solanaWalletAddress != null) {
      solanaAddressWalletController.text = provider.userAccountInfo!.solanaWalletAddress!;
      solanaAddressWallet = solanaAddressWalletController.text;
    }
  }

  @override
  void dispose() {
    solanaAddressWalletController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) => getIt<SolanaAddressWalletProvider>(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: AppShadowBackground(
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.paddingVeryLarge),
              child: Column(
                children: [
                  AppHeader(headerText: AppString.solanaAddressWallet),
                  AppDimens.vSpaceLarge,
                  SvgPicture.asset(
                    AppImages.solanaAddressWallet,
                    height: size.height * 0.25,
                    width: size.height * 0.25,
                    fit: BoxFit.contain,
                  ),
                  AppDimens.vSpaceMedium,
                  AppTextFormField.withTitle(
                    title: AppString.solanaAddressWallet,
                    controller: solanaAddressWalletController,
                    hintText: AppString.enterSolanaAddressWallet,
                    textInputAction: TextInputAction.done,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Spacer(),
                  Selector<SolanaAddressWalletProvider, SolanaAddressWalletStatus>(
                    selector: (context, provider) => provider.status,
                    builder: (context, status, child) {
                      if (status == SolanaAddressWalletStatus.success) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          context.pop();
                        });
                      }
                      return AppButton(
                        isLoading: status == SolanaAddressWalletStatus.loading,
                        text: AppString.confirm,
                        onTap: () {
                          if (solanaAddressWalletController.text.isNotEmpty &&
                              solanaAddressWalletController.text != solanaAddressWallet) {
                            Provider.of<SolanaAddressWalletProvider>(context, listen: false)
                                .changeSolanaAddressWallet(
                              solanaAddressWalletController.text,
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
      ),
    );
  }
}
