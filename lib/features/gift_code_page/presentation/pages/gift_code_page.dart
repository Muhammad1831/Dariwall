import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_text_field.dart';
import 'package:dariwall/features/gift_code_page/presentation/provider/send_gift_code_provider.dart';
import 'package:dariwall/features/gift_code_page/presentation/provider/verify_gift_code_provider.dart';
import 'package:provider/provider.dart';

class GiftCodePage extends StatefulWidget {
  const GiftCodePage({super.key});

  @override
  State<GiftCodePage> createState() => _GiftCodePageState();
}

class _GiftCodePageState extends State<GiftCodePage> {
  final TextEditingController _giftCodeController = TextEditingController();
  String? lastGiftCode;

  @override
  void dispose() {
    _giftCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt<VerifyGiftCodeProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<SendGiftCodeProvider>(),
        ),
        ValueListenableProvider<TextEditingValue>.value(
          value: _giftCodeController,
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: AppShadowBackground(
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with back button
                  AppHeader(
                    headerText: AppString.giftCode,
                  ),
                  AppDimens.vSpaceLarge,
                  // Gift Image
                  Center(
                    child: Image.asset(
                      AppImages.giftCode,
                      width: size.height * 0.25,
                      height: size.height * 0.25,
                    ),
                  ),
                  AppDimens.vSpaceLarge,
                  Text(
                    AppString.giftCode,
                    style: theme.textTheme.titleMedium,
                  ),
                  AppDimens.vSpaceVeryVerySmall,
                  // Verification Instructions
                  Selector2<VerifyGiftCodeProvider, TextEditingValue, (VerifyGiftCodeStatus, String)>(
                    selector: (context, provider, controller) => (provider.status, controller.text),
                    builder: (context, value, child) {
                      final giftCode = value.$2;
                      final status = value.$1;
            
                      return Row(
                        spacing: AppDimens.verySmall,
                        children: [
                          Expanded(
                            child: AppTextFormField(
                              controller: _giftCodeController,
                              hintText: AppString.giftCodeExample,
                              enabledBorderColor: status == VerifyGiftCodeStatus.success
                                  ? AppColor.successColor
                                  : status == VerifyGiftCodeStatus.error
                                      ? AppColor.errorColor
                                      : theme.colorScheme.surface,
                              focusedBorderColor: status == VerifyGiftCodeStatus.success
                                  ? AppColor.successColor
                                  : status == VerifyGiftCodeStatus.error
                                      ? AppColor.errorColor
                                      : theme.colorScheme.secondary,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.25,
                            child: AppButton(
                              isLoading: status == VerifyGiftCodeStatus.loading,
                              text: AppString.giftCodeVerification,
                              bgColor: giftCode.isEmpty
                                  ? theme.disabledColor
                                  : theme.colorScheme.secondary,
                              onTap: () {
                                if (giftCode.isNotEmpty) {
                                  context
                                      .read<VerifyGiftCodeProvider>()
                                      .verifyGiftCode(giftCode: giftCode);
                                  lastGiftCode = giftCode;
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  AppDimens.vSpaceMedium,
                  Text(
                    AppString.giftCodeVerificationDescription,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  AppDimens.vSpaceMedium,
                  Text(
                    AppString.clickOnTheVerificationButton,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  AppDimens.vSpaceVerySmall,
                  Text(
                    AppString.waitForTheVerificationResult,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  // send gift code
                  Selector2<SendGiftCodeProvider, VerifyGiftCodeProvider,
                      (SendGiftCodeStatus, VerifyGiftCodeStatus)>(
                    selector: (context, sendProvider, verifyProvider) =>
                        (sendProvider.status, verifyProvider.status),
                    builder: (context, statuses, child) {
                      if (statuses.$1 == SendGiftCodeStatus.success) {
                        WidgetsBinding.instance.addPostFrameCallback((_) => context.pop());
                      }
            
                      return AppButton(
                        isLoading: statuses.$1 == SendGiftCodeStatus.loading,
                        text: AppString.receiveGift,
                        bgColor: _giftCodeController.text == lastGiftCode &&
                                statuses.$2 == VerifyGiftCodeStatus.success
                            ? null
                            : theme.disabledColor,
                        onTap: () {
                          if (_giftCodeController.text.isNotEmpty &&
                              _giftCodeController.text == lastGiftCode &&
                              statuses.$2 == VerifyGiftCodeStatus.success) {
                            context
                                .read<SendGiftCodeProvider>()
                                .sendGiftCode(giftCode: _giftCodeController.text);
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
