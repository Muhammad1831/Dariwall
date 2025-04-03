import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_string.dart';

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
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: widget.navigationShell,
        bottomNavigationBar: BottomAppBar(
          height: 64.r,
          color: theme.cardTheme.color,
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
                    AppColor.infoColor,
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
                fontSize: 10.sp,
                color: currentIndex == index ? AppColor.infoColor : theme.iconTheme.color!,
              ),
            ),
          ),
          // if (currentIndex == index)
          //   Container(
          //     height: AppDimens.veryVerySmall,
          //     width: AppDimens.veryVerySmall,
          //     decoration: BoxDecoration(
          //       color: AppColor.infoColor,
          //       shape: BoxShape.circle,
          //     ),
          //   ),
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
