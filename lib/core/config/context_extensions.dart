import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  void showSnackBar(String message, {Color? textColor, Color? color, SnackBarAction? action}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            style: Theme.of(this).textTheme.bodyMedium?.copyWith(
              color: textColor ?? Colors.white,
            ),
          ),
        ),
        backgroundColor: color ?? Colors.black,
        action: action,
      ),
    );
  }

  void unFocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

extension CustomTextStyles on BuildContext {
  TextStyle? get headingMediumTextStyle30 {
    return Theme.of(this).textTheme.headlineMedium;
  }

  TextStyle? get titleLargeTextStyle20 {
    return Theme.of(this).textTheme.titleLarge;
  }

  TextStyle? get bodyLargeTextStyle15 {
    return Theme.of(this).textTheme.bodyLarge;
  }

  TextStyle? get bodyMediumTextStyle {
    return Theme.of(this).textTheme.bodyMedium;
  }

  TextStyle? get labelLargeTextStyle13 {
    return Theme.of(this).textTheme.labelLarge;
  }

  TextStyle? get labelMediumTextStyle12 {
    return Theme.of(this).textTheme.labelMedium;
  }

  TextStyle? get labelSmallTextStyle {
    return Theme.of(this).textTheme.labelSmall;
  }
}
