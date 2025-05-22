import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/utils/utils_cached_image.dart';
import 'package:dariwall/core/widgets/app_dialog.dart';
import 'package:dariwall/features/login/presentation/provider/login_provider.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';
import 'package:provider/provider.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({super.key});

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetUserAccountInfoProvider>().getUserAccountInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final userImage = Provider.of<GetUserAccountInfoProvider>(context).userAccountInfo?.accountImage;

    return SingleChildScrollView(
      child: AppShadowBackground(
        child: Padding(
          padding: EdgeInsets.only(top: AppDimens.extraLarge),
          child: Column(
            children: [
              (userImage != null && userImage.isNotEmpty)
                  ? AppCachedImage(
                      imageUrl: userImage,
                      shape: BoxShape.circle,
                      height: size.height * 0.1,
                      width: size.height * 0.1,
                    )
                  : Image.asset(
                      AppImages.avatar,
                      height: size.width * 0.25,
                      width: size.width * 0.25,
                    ),
              AppDimens.vSpaceMedium,
              InkWell(
                onTap: () {
                  context.pushNamed(AppRouteName.userAccountInfoEdit);
                },
                borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
                child: Padding(
                  padding: EdgeInsets.all(AppDimens.paddingSmall),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: AppDimens.verySmall,
                    children: [
                      Text(
                        Provider.of<GetUserAccountInfoProvider>(context).userAccountInfo?.name ??
                            '',
                      ),
                      Icon(
                        CupertinoIcons.chevron_down,
                        size: AppDimens.iconMedium,
                      )
                    ],
                  ),
                ),
              ),
              AppDimens.vSpaceLarge,
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // security
                  UserAccountItem(
                    icon: AppIcons.lockClose,
                    title: AppString.security,
                    onTap: () {
                      context.pushNamed(AppRouteName.comingSoon);
                    },
                  ),
                  // solana address wallet
                  UserAccountItem(
                    icon: AppIcons.wallet,
                    title: AppString.solanaAddressWallet,
                    onTap: () {
                      context.pushNamed(AppRouteName.solanaAddressWallet);
                    },
                  ),
                  // gift code
                  UserAccountItem(
                    icon: AppIcons.gift,
                    title: AppString.giftCode,
                    onTap: () {
                      context.pushNamed(AppRouteName.giftCode);
                    },
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
                    onTap: () {
                      context.pushNamed(AppRouteName.aboutUs);
                    },
                  ),
                  // logout
                  InkWell(
                    onTap: () async {
                      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AppDialog(
                            confirmAction: () async {
                              await loginProvider.logout();
                              if (loginProvider.status == LoginStatus.loggedOut) {
                                context.goNamed(AppRouteName.welcome);
                              }
                            },
                            title: AppString.areYouSureLogout,
                            content: AppString.areYouSureLogoutContent,
                          );
                        },
                      );
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
        ),
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
