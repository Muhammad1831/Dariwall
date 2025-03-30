import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/features/login/presentation/provider/auth_provider.dart';
import 'package:ostad/core/route/app_route_name.dart';
import 'package:provider/provider.dart';

enum NavBarItem {
  wallet,
  home,
  priceInfo,
  account,
}

class ScaffoldWithNavBar extends StatefulWidget {
  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int currentIndex = NavBarItem.home.index;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppDimens.medium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
                    child: Padding(
                      padding: EdgeInsets.all(AppDimens.verySmall),
                      child: SvgPicture.asset(
                        AppIcons.drawer,
                        height: AppDimens.iconLarge,
                        width: AppDimens.iconLarge,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
                    child: Padding(
                      padding: EdgeInsets.all(AppDimens.verySmall),
                      child: SvgPicture.asset(
                        AppIcons.notification,
                        height: AppDimens.iconLarge,
                        width: AppDimens.iconLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: widget.navigationShell,
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppDimens.vSpaceVeryLarge,
              Image.asset(
                AppImages.logo,
                height: 64.r,
                width: 64.r,
                fit: BoxFit.scaleDown,
              ),
              AppDimens.vSpaceSmall,
              Text(
                'علیرضا قاسمی',
                style: theme.textTheme.titleMedium,
              ),
              AppDimens.vSpaceExtraLarge,
              ListTile(
                onTap: () {
                  GoRouter.of(context).push(AppRouteName.learnAndGuide);
                },
                leading: SvgPicture.asset(AppIcons.lightBulb),
                title: Text(
                  AppString.learnAndGuide,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  final authProvider = Provider.of<AuthProvider>(context, listen: false);
                  authProvider.logout();
                  if (!authProvider.isAuthenticated) {
                    GoRouter.of(context).go(AppRouteName.login);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppDimens.medium),
                  child: Center(
                    child: Text(
                      AppString.logout,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: AppColor.errorColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: theme.cardTheme.color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildNavItem(
                  NavBarItem.wallet.index,
                  AppIcons.wallet,
                  AppString.wallet,
                ),
              ),
              Expanded(
                child: _buildNavItem(
                  NavBarItem.home.index,
                  AppIcons.home,
                  AppString.home,
                ),
              ),
              Expanded(
                child: _buildNavItem(
                  NavBarItem.priceInfo.index,
                  AppIcons.priceInfo,
                  AppString.priceInfo,
                ),
              ),
              Expanded(
                child: _buildNavItem(
                  NavBarItem.account.index,
                  AppIcons.account,
                  AppString.account,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String icon, String title) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => changeTab(index),
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      child: Column(
        spacing: AppDimens.veryVerySmall / 2,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            height: AppDimens.iconLarge,
            width: AppDimens.iconLarge,
            colorFilter: currentIndex == index
                ? ColorFilter.mode(
                    AppColor.infoColor,
                    BlendMode.srcIn,
                  )
                : ColorFilter.mode(
                    theme.iconTheme.color!,
                    BlendMode.srcIn,
                  ),
          ),
          Text(
            title,
            style: theme.textTheme.bodySmall!.copyWith(
              fontSize: 10.sp,
              color: currentIndex == index ? AppColor.infoColor : theme.iconTheme.color!,
            ),
          ),
          if (currentIndex == index)
            Container(
              height: AppDimens.veryVerySmall,
              width: AppDimens.veryVerySmall,
              decoration: BoxDecoration(
                color: AppColor.infoColor,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  void changeTab(int index) {
    setState(() {
      currentIndex = index;
    });

    switch (index) {
      case 0:
        goBranch(NavBarItem.wallet.index);
        break;
      case 1:
        goBranch(NavBarItem.home.index);
        break;
      case 2:
        goBranch(NavBarItem.priceInfo.index);
        break;
      case 3:
        goBranch(NavBarItem.account.index);
        break;
    }
  }

  void goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
    );
  }
}
