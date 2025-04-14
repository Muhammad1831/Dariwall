import 'package:flutter/material.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_string.dart';

enum Language { persian, english }

class LanguageSelectionModal extends StatefulWidget {
  const LanguageSelectionModal({super.key});

  @override
  State<LanguageSelectionModal> createState() => _LanguageSelectionModalState();
}

class _LanguageSelectionModalState extends State<LanguageSelectionModal> {
  Language _language = Language.persian;

  void changeLanguage(Language language) {
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimens.borderRadiusVeryLarge),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppDimens.vSpaceLarge,
          Text(
            AppString.chooseLanguage,
            style: theme.textTheme.titleLarge,
          ),
          AppDimens.vSpaceLarge,
          Divider(),
          _LanguageOption(
            title: AppString.farsi,
            subtitle: '(${AppString.persian})',
            isSelected: _language == Language.persian,
            onTap: () {
              changeLanguage(Language.persian);
              Navigator.pop(context);
            },
          ),
          Divider(),
          _LanguageOption(
            title: AppString.englisi,
            subtitle: '(${AppString.english})',
            isSelected: _language == Language.english,
            onTap: () {
              changeLanguage(Language.english);
              Navigator.pop(context);
            },
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimens.paddingMedium),
            child: Text(
              AppString.youCanChangeLanguageInSetting,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(AppDimens.paddingMedium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$title $subtitle',
                style: theme.textTheme.titleMedium,
              ),
              Container(
                width: AppDimens.iconLarge,
                height: AppDimens.iconLarge,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? theme.primaryColor : theme.colorScheme.onSurface,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.primaryColor,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
