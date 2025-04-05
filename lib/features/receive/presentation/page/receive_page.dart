import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/widgets/app_header.dart';

class ReceivePage extends StatelessWidget {
  const ReceivePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ReceiveItem(theme: theme);
                  },
                ),
              )
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
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
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
                      'Solana',
                      style: theme.textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'UioQ...mKcE',
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
                onTap: () {},
              ),
              AppDimens.hSpaceVerySmall,
              ReceiveItemAction(
                title: AppString.barcode,
                icon: AppIcons.barcode,
                onTap: () {},
              )
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
    return DecoratedBox(
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
    );
  }
}
