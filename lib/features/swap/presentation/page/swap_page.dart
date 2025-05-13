import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_button.dart';

class SwapPage extends StatefulWidget {
  const SwapPage({super.key});

  @override
  State<SwapPage> createState() => _SwapPageState();
}

class _SwapPageState extends State<SwapPage> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  String _selectedFromToken = 'SOL';
  String _selectedToToken = 'OSTAD';

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeader(headerText: AppString.swapToken),
              AppDimens.vSpaceLarge,
              _buildSwapCard(theme),
              AppDimens.vSpaceMedium,
              Spacer(),
              _buildSwapButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwapCard(ThemeData theme) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            _buildTokenInput(
              theme,
              controller: _fromController,
              selectedToken: _selectedFromToken,
              onTokenSelect: (token) {
                setState(() => _selectedFromToken = token);
              },
              isFrom: true,
            ),
            AppDimens.vSpaceMedium,
            _buildTokenInput(
              theme,
              controller: _toController,
              selectedToken: _selectedToToken,
              onTokenSelect: (token) {
                setState(() => _selectedToToken = token);
              },
              isFrom: false,
            ),
          ],
        ),
        Center(child: _buildSwapIcon(theme)),
      ],
    );
  }

  Widget _buildTokenInput(
    ThemeData theme, {
    required TextEditingController controller,
    required String selectedToken,
    required Function(String) onTokenSelect,
    required bool isFrom,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusMedium),
      ),
      padding: EdgeInsets.all(AppDimens.paddingMedium),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppDimens.small,
              children: [
                Text(
                  'پرداخت',
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  '123',
                  style: theme.textTheme.displaySmall,
                ),
                Text(
                  '\$120',
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          AppDimens.hSpaceSmall,
          _buildTokenSelector(
            theme,
            selectedToken: selectedToken,
            onTokenSelect: onTokenSelect,
          ),
        ],
      ),
    );
  }

  Widget _buildTokenSelector(
    ThemeData theme, {
    required String selectedToken,
    required Function(String) onTokenSelect,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.paddingSmall,
        vertical: AppDimens.paddingVerySmall,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusExtraLarge),
      ),
      child: DropdownButton<String>(
        value: selectedToken,
        items: ['SOL', 'OSTAD'].map((String token) {
          return DropdownMenuItem<String>(
              value: token,
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.solana),
                  AppDimens.hSpaceSmall,
                  Text(token),
                ],
              ));
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            onTokenSelect(newValue);
          }
        },
        underline: SizedBox(),
        style: theme.textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildSwapIcon(ThemeData theme) {
    return IconButton(
      onPressed: () {
        setState(() {
          final tempToken = _selectedFromToken;
          _selectedFromToken = _selectedToToken;
          _selectedToToken = tempToken;

          final tempValue = _fromController.text;
          _fromController.text = _toController.text;
          _toController.text = tempValue;
        });
      },
      icon: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusExtraLarge),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppDimens.paddingSmall),
          child: SvgPicture.asset(AppIcons.swap),
        ),
      ),
    );
  }

  Widget _buildSwapButton() {
    return AppButton(
      text: AppString.swap,
      onTap: () {
        // Implement swap functionality
      },
    );
  }
}
