import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/route/app_route_name.dart';
import 'package:ostad/features/login/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class UserAccountPage extends StatelessWidget {
  const UserAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppDimens.paddingLarge,
      ),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(AppDimens.paddingExtraLarge),
              child: SvgPicture.asset(
                AppIcons.account,
                height: AppDimens.iconExtraLarge,
                width: AppDimens.iconExtraLarge,
              ),
            ),
          ),
          AppDimens.vSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppDimens.verySmall,
            children: [
              Text(AppString.userName),
              Icon(
                Icons.chevron_right,
              )
            ],
          ),
          AppDimens.vSpaceLarge,
          ListView(
            shrinkWrap: true,
            children: [
              // security
              UserAccountItem(
                icon: AppIcons.lockClose,
                title: AppString.security,
                onTap: () {},
              ),
              // phantom wallet address
              UserAccountItem(
                icon: AppIcons.wallet,
                title: AppString.phantomWalletAddress,
                onTap: () {},
              ),
              // gift code
              UserAccountItem(
                icon: AppIcons.gift,
                title: AppString.giftCode,
                onTap: () {},
              ),
              // learn and guide
              UserAccountItem(
                icon: AppIcons.lightBulb,
                title: AppString.learnAndGuide,
                onTap: () {
                  context.pushNamed(AppRouteName.learnAndGuide);
                },
              ),
              // invite friends
              UserAccountItem(
                icon: AppIcons.friends,
                title: AppString.inviteFriends,
                onTap: () {
                  context.pushNamed(AppRouteName.inviteFriends);
                },
              ),
              // about us
              UserAccountItem(
                icon: AppIcons.smile,
                title: AppString.aboutUs,
                onTap: () {},
              ),
              // logout
              InkWell(
                onTap: () {
                  final authProvider = Provider.of<AuthProvider>(context, listen: false);
                  authProvider.logout();
                  if (!authProvider.isAuthenticated) {
                    context.goNamed(AppRouteName.login);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(
                    AppDimens.paddingMedium,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: theme.colorScheme.error,
                        size: AppDimens.iconMedium,
                      ),
                      AppDimens.hSpaceSmall,
                      Text(
                        AppString.logout,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: AppColor.errorColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class UserAccountItem extends StatelessWidget {
  const UserAccountItem({
    super.key,
    required this.icon,
    required this.onTap,
    required this.title,
  });

  final String title;
  final String icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(
              AppDimens.paddingMedium,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  icon,
                  height: AppDimens.iconMedium,
                  width: AppDimens.iconMedium,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
                AppDimens.hSpaceSmall,
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Icon(
                  CupertinoIcons.chevron_back,
                  size: AppDimens.iconMedium,
                ),
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
