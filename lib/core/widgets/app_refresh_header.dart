import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/widgets/app_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppRefresher extends StatelessWidget {
  const AppRefresher({
    super.key,
    required this.refreshController,
    required this.onRefresh,
    required this.child,
  });

  final RefreshController refreshController;
  final Future<void> Function() onRefresh;
  final Widget child;

  String getText(RefreshStatus? mode) {
    if (mode == RefreshStatus.idle) {
      return AppMessage.pullToRefresh;
    } else if (mode == RefreshStatus.canRefresh) {
      return AppMessage.releaseToRefresh;
    } else if (mode == RefreshStatus.refreshing) {
      return AppMessage.refreshing;
    } else if (mode == RefreshStatus.completed) {
      return AppMessage.refreshCompleted;
    }
    return '';
  }

  Widget getHeader(BuildContext context, RefreshStatus? mode) {
    final theme = Theme.of(context);
    if (mode == RefreshStatus.idle) {
      return SizedBox(
        height: 60,
        child: Row(
          spacing: AppDimens.veryVerySmall,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_downward, color: theme.colorScheme.onPrimary),
            Text(
              getText(mode),
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    } else if (mode == RefreshStatus.canRefresh) {
      return SizedBox(
        height: 60,
        child: Row(
          spacing: AppDimens.veryVerySmall,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_upward, color: theme.colorScheme.onPrimary),
            Text(
              getText(mode),
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    } else if (mode == RefreshStatus.refreshing) {
      return SizedBox(
        height: 60,
        child: Row(
          spacing: AppDimens.small,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLoading(),
            Text(
              getText(mode),
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    } else if (mode == RefreshStatus.completed) {
      return SizedBox(
        height: 60,
        child: Row(
          spacing: AppDimens.small,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check, color: theme.colorScheme.primary),
            Text(
              getText(mode),
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: false,
      primary: true,
      onRefresh: () async {
        await onRefresh();
        refreshController.refreshCompleted();
      },
      header: CustomHeader(
        refreshStyle: RefreshStyle.Follow,
        builder: (context, mode) {
          return getHeader(context, mode);
        },
      ),
      child: child,
    );
  }
}
