import 'package:flutter/material.dart';
import 'package:ostad/constant/app_dimens.dart';
import 'package:ostad/constant/app_string.dart';
import 'package:ostad/utils/extensions.dart';

/// Defines the types of validation that can be applied to the text field
enum ValidationType {
  notEmpty, // can not be empty validation
  password, // Password validation
  repeatPassword, // Repeat password validation
  email, // Email validation
  phoneNumber, // Phone number validation
}

/// A custom TextFormField widget that provides various styling and validation options
/// ignore: must_be_immutable - because we need to modify obscureText state
class AppTextFormField extends StatelessWidget {
  AppTextFormField({
    super.key,
    required this.controller, // Text editing controller
    this.autovalidateMode, // When to validate the input
    this.enabled = true, // Whether the field is enabled
    this.canRequestFocus = true, // Whether the field can receive focus
    this.expands = false, // Whether the field expands to fill its parent
    this.obscuringCharacter = '•', // Character to show for obscured text
    this.textInputAction, // Keyboard action button type
    this.keyboardType, // Type of keyboard to show
    this.minLength, // Minimum length for validation
    this.maxLength, // Maximum length for input
    this.maxLines = 1, // Maximum number of lines
    this.minLines, // Minimum number of lines
    this.obscureText = false, // Whether to hide the text (for passwords)
    this.textAlign, // Text alignment
    this.style, // Text style
    this.validationType, // Type of validation to apply
    this.validator, // Custom validator function
    this.enableCounter = false, // Whether to show character counter
    this.buildCounter, // Custom counter builder
    this.contentPaddingVertical, // Vertical padding
    this.contentPaddingHorizontal, // Horizontal padding
    this.fillColor, // Background color
    this.borderRadius, // Border corner radius
    this.disabledBorderColor, // Border color when disabled
    this.enabledBorderColor, // Border color when enabled
    this.errorBorderColor, // Border color when error
    this.focusedBorderColor, // Border color when focused
    this.focusedErrorBorderColor, // Border color when focused with error
    this.labelText, // Label text
    this.hintText, // Hint text
    this.suffixIcon, // Custom suffix icon
    this.suffixIconColor, // Suffix icon color
    this.floatingLabelBehavior, // How the label should behave
    this.hintStyle, // Hint text style
    this.labelStyle, // Label text style
    this.errorText, // Custom error message
    this.title, // title for textformfield
    this.focusNode,
    this.onChanged,
  });

  AppTextFormField.withTitle({
    super.key,
    required this.title, // title for textformfield
    required this.controller, // Text editing controller
    this.autovalidateMode, // When to validate the input
    this.enabled = true, // Whether the field is enabled
    this.canRequestFocus = true, // Whether the field can receive focus
    this.expands = false, // Whether the field expands to fill its parent
    this.obscuringCharacter = '•', // Character to show for obscured text
    this.textInputAction, // Keyboard action button type
    this.keyboardType, // Type of keyboard to show
    this.minLength, // Minimum length for validation
    this.maxLength, // Maximum length for input
    this.maxLines = 1, // Maximum number of lines
    this.minLines, // Minimum number of lines
    this.obscureText = false, // Whether to hide the text (for passwords)
    this.textAlign, // Text alignment
    this.style, // Text style
    this.validationType, // Type of validation to apply
    this.validator, // Custom validator function
    this.enableCounter = false, // Whether to show character counter
    this.buildCounter, // Custom counter builder
    this.contentPaddingVertical, // Vertical padding
    this.contentPaddingHorizontal, // Horizontal padding
    this.fillColor, // Background color
    this.borderRadius, // Border corner radius
    this.disabledBorderColor, // Border color when disabled
    this.enabledBorderColor, // Border color when enabled
    this.errorBorderColor, // Border color when error
    this.focusedBorderColor, // Border color when focused
    this.focusedErrorBorderColor, // Border color when focused with error
    this.labelText, // Label text
    this.hintText, // Hint text
    this.suffixIcon, // Custom suffix icon
    this.suffixIconColor, // Suffix icon color
    this.floatingLabelBehavior, // How the label should behave
    this.hintStyle, // Hint text style
    this.labelStyle, // Label text style
    this.errorText, // Custom error message
    this.focusNode,
    this.onChanged,
  });

  final TextEditingController controller;
  final AutovalidateMode? autovalidateMode;
  final bool enabled;
  final bool canRequestFocus;
  final bool expands;
  final String obscuringCharacter;
  final String? labelText;
  final String? hintText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? minLength;
  final int? maxLines;
  final int? minLines;
  bool obscureText;
  final TextAlign? textAlign;
  final TextStyle? style;
  final ValidationType? validationType;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final bool enableCounter;
  final Widget? Function(BuildContext,
      {required int currentLength, required bool isFocused, required int? maxLength})? buildCounter;
  final double? contentPaddingVertical;
  final double? contentPaddingHorizontal;
  final Color? fillColor;
  final double? borderRadius;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? focusedErrorBorderColor;
  final Color? enabledBorderColor;
  final Color? disabledBorderColor;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final String? errorText;
  final String? title;
  final FocusNode? focusNode;
  final Function(String value)? onChanged;

  /// Validates email format
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.enterEmail;
    }
    if (!value.isValidEmail()) {
      return AppString.enterValidEmail;
    }
    return null;
  }

  /// Validates Iranian phone number format
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.enterPhoneNumber;
    }
    if (!value.isValidIranianPhoneNumber()) {
      return AppString.enterValidPhoneNumber;
    }
    return null;
  }

  /// Validates password requirements
  /// Checks for:
  /// - Minimum length
  /// - Uppercase letters
  /// - Lowercase letters
  /// - Numbers
  /// - Special characters
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      if (validationType == ValidationType.password) {
        return AppString.enterPassword;
      } else {
        return AppString.enterRepeatPassword;
      }
    }

    if (minLength != null && value.length < minLength!) {
      return AppString.minimumCharacterPassword(minLength!);
    }

    RegExp upperCaseRegex = RegExp(r'[A-Z]');
    RegExp lowerCaseRegex = RegExp(r'[a-z]');
    RegExp digitRegex = RegExp(r'\d');
    RegExp specialCharRegex = RegExp(r'[@#_!*&$]');

    if (!upperCaseRegex.hasMatch(value) ||
        !lowerCaseRegex.hasMatch(value) ||
        !digitRegex.hasMatch(value) ||
        !specialCharRegex.hasMatch(value)) {
      return AppString.passwordMustContainLettersAndNumbersAndSpecialCharacter;
    }

    return null;
  }

  /// Basic validation for required fields
  String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return errorText ?? AppString.thisFieldMustNotBeEmpty;
    }
    return null;
  }

  /// Selects appropriate validation based on ValidationType
  String? selectValidatorType(String? value) {
    switch (validationType) {
      case ValidationType.notEmpty:
        return validateNotEmpty(value);

      case ValidationType.password:
        return validatePassword(value);

      case ValidationType.repeatPassword:
        return validatePassword(value);

      case ValidationType.email:
        return validateEmail(value);

      case ValidationType.phoneNumber:
        return validatePhoneNumber(value);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        AppDimens.vSpaceVeryVerySmall,
        TextFormField(
          // Basic configuration
          focusNode: focusNode,
          controller: controller,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
          onChanged: onChanged,

          // Input behavior
          enabled: enabled,
          canRequestFocus: canRequestFocus,
          expands: expands,
          obscuringCharacter: obscuringCharacter,

          // Keyboard configuration
          textInputAction: textInputAction ?? TextInputAction.done,
          keyboardType: keyboardType ?? TextInputType.text,

          // Text layout
          maxLength: maxLength,
          maxLines: maxLines,
          minLines: minLines,
          obscureText: obscureText,
          textAlignVertical: TextAlignVertical.center,
          textAlign: textAlign ?? TextAlign.start,

          // Styling
          style: style ?? Theme.of(context).textTheme.bodyMedium,

          // Validation
          validator: validator ?? selectValidatorType,

          // Counter
          buildCounter: buildCounter,

          // Decoration (uses theme with custom overrides)
          decoration: InputDecoration(
            counter: enableCounter ? null : const SizedBox.shrink(),
            contentPadding: EdgeInsets.symmetric(
              vertical: contentPaddingVertical ?? AppDimens.paddingSmall,
              horizontal: contentPaddingHorizontal ?? AppDimens.paddingLarge,
            ),
            labelText: labelText,
            hintText: hintText,
            labelStyle: labelStyle ?? Theme.of(context).inputDecorationTheme.labelStyle,
            hintStyle: hintStyle ?? Theme.of(context).inputDecorationTheme.hintStyle,
            errorMaxLines: 2,
            filled: Theme.of(context).inputDecorationTheme.filled,
            fillColor: fillColor ?? Theme.of(context).inputDecorationTheme.fillColor,
            border: Theme.of(context).inputDecorationTheme.border,
            enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
            errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
            focusedErrorBorder: Theme.of(context).inputDecorationTheme.focusedErrorBorder,
            suffixIcon: suffixIcon,
            suffixIconColor:
                suffixIconColor ?? Theme.of(context).inputDecorationTheme.suffixIconColor,
          ),
        ),
      ],
    );
  }
}
