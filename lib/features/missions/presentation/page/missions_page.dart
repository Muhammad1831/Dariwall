import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/route/app_route_name.dart';

class MissionsPage extends StatelessWidget {
  const MissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.paddingMedium,
        vertical: AppDimens.paddingLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppString.missions,
            style: theme.textTheme.displaySmall,
          ),
          AppDimens.vSpaceLarge,
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                //TODO: must be deleted
                return MissionsItem(
                  index: index,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class MissionsItem extends StatelessWidget {
  const MissionsItem({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimens.borderRadiusSmall),
      child: Material(
            color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
          ),
          child: InkWell(
            onTap: () {
              if (index == 0) {
                context.pushNamed(AppRouteName.followX);
              }
              if (index == 1) {
                context.pushNamed(AppRouteName.learnAndGuide);
              }
              if (index == 2) {
                context.pushNamed(AppRouteName.likeCoinmarketcap);
              }
            },
            borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: AppDimens.paddingSmall),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
                    child: SvgPicture.asset(AppIcons.coinAlt),
                  ),
                  SizedBox(
                    height: AppDimens.extraLarge,
                    child: VerticalDivider(
                      color: theme.colorScheme.secondary,
                      width: 0,
                      thickness: 0.5,
                    ),
                  ),
                  AppDimens.hSpaceVerySmall,
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppDimens.paddingSmall),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppDimens.verySmall,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'دنبال کردن OSTAD در توئیتر',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Row(
                            spacing: AppDimens.veryVerySmall,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'پاداش:',
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                '\$1',
                                style: theme.textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.warningColor,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.chevron_right,
                      size: AppDimens.iconLarge,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
