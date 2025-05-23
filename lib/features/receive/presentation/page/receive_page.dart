import 'package:dariwall/core/extensions/to_short_wallet_address_extensions.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/utils/utils_clipboard.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:provider/provider.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({super.key});

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  String? solanaWalletAddress;

  @override
  void initState() {
    super.initState();
    if (context.read<GetUserAccountInfoProvider>().userAccountInfo != null) {
      solanaWalletAddress =
          context.read<GetUserAccountInfoProvider>().userAccountInfo!.solanaWalletAddress;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppDimens.paddingLarge,
            horizontal: AppDimens.paddingMedium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppHeader(headerText: AppString.receive),
              AppDimens.vSpaceMedium,
              SvgPicture.asset(
                AppImages.receive,
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
              AppDimens.vSpaceMedium,
              if (solanaWalletAddress != null)
                ReceiveItem(
                  solanaWalletAddress: solanaWalletAddress!,
                ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: 1,
              //     itemBuilder: (context, index) {
              //       return ReceiveItem();
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class ReceiveItem extends StatelessWidget {
  const ReceiveItem({
    super.key,
    required this.solanaWalletAddress,
  });

  final String solanaWalletAddress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimens.paddingSmall),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.borderRadiusSmall),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppDimens.paddingSmall),
          child: Row(
            children: [
              SvgPicture.asset(AppIcons.solana),
              AppDimens.hSpaceSmall,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppDimens.verySmall,
                  children: [
                    Text(
                      AppString.solana,
                      style: theme.textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        solanaWalletAddress.toShortWalletAddress(),
                        style: theme.textTheme.titleSmall!.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ReceiveItemAction(
                title: AppString.copy,
                icon: AppIcons.copy,
                onTap: () async {
                  await UtilsClipboard.copyToClipboard(text: solanaWalletAddress);
                  SnackBarService.show(
                    status: SnackBarStatus.success,
                    message: AppString.addressWalletCopiedSuccessfuly,
                  );
                },
              ),
              // AppDimens.hSpaceVerySmall,
              // ReceiveItemAction(
              //   title: AppString.barcode,
              //   icon: AppIcons.barcode,
              //   onTap: () {},
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class ReceiveItemAction extends StatelessWidget {
  const ReceiveItemAction({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.borderRadiusVerySmall),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppDimens.paddingVerySmall,
            horizontal: AppDimens.paddingSmall,
          ),
          child: Column(
            children: [
              SvgPicture.asset(icon),
              Text(
                title,
              )
            ],
          ),
        ),
      ),
    );
  }
}
