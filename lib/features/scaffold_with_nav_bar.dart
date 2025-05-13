import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:provider/provider.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/features/missions/presentation/provider/get_missions_provider.dart';

enum NavBarItem {
  home,
  transactions,
  missions,
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
    return ChangeNotifierProvider.value(
      value: getIt<GetMissionsProvider>(),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: widget.navigationShell,
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: AppDimens.paddingMedium),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(100),
                  borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
                  gradient: AppColor.glassGradia,
                  border: Border.all(
                    color: Colors.white.withAlpha(15),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildNavItem(
                        NavBarItem.home.index,
                        AppIcons.home,
                        AppString.home,
                      ),
                    ),
                    Expanded(
                      child: _buildNavItem(
                        NavBarItem.transactions.index,
                        AppIcons.buy,
                        AppString.transactions,
                      ),
                    ),
                    Expanded(
                      child: _buildNavItem(
                        NavBarItem.missions.index,
                        AppIcons.crown,
                        AppString.missions,
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
        spacing: AppDimens.veryVerySmall,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            fit: BoxFit.contain,
            height: AppDimens.iconMedium,
            width: AppDimens.iconMedium,
            colorFilter: currentIndex == index
                ? ColorFilter.mode(
                    theme.primaryIconTheme.color!,
                    BlendMode.srcIn,
                  )
                : ColorFilter.mode(
                    theme.iconTheme.color!,
                    BlendMode.srcIn,
                  ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: theme.textTheme.bodySmall!.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color:
                    currentIndex == index ? theme.primaryIconTheme.color : theme.iconTheme.color!,
              ),
            ),
          ),
          if (currentIndex == index)
            Container(
              height: AppDimens.veryVerySmall,
              width: AppDimens.medium,
              decoration: BoxDecoration(
                color: theme.primaryColor,
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
        goBranch(NavBarItem.home.index);
        break;
      case 1:
        goBranch(NavBarItem.transactions.index);
        break;
      case 2:
        goBranch(NavBarItem.missions.index);
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
