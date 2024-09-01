import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/app_colors.dart';

class DefaultButton extends StatelessWidget {
  final String label;
  final Widget? labelWidget;
  final double? width;
  final void Function()? onPressed;
  final TextStyle? labelStyle;
  final Color? buttonColor;
  final Color? labelColor;
  final Widget? buttonIcon;
  final bool withBorder;
  final bool withoutWidth;

  const DefaultButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.labelStyle,
    this.width,
    this.buttonColor,
    this.labelColor = Colors.white,
    this.buttonIcon,
    this.withBorder = false,
    this.labelWidget,
    this.withoutWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: withoutWidth ? 400.w : width ?? 378.w),
      child: SizedBox(
        width: withoutWidth ? null : width ?? double.infinity,
        height: 56.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
            backgroundColor: buttonColor ?? AppColors.primaryColor,
            surfaceTintColor: buttonColor ?? Colors.white,
            shadowColor: buttonColor,
            shape: RoundedRectangleBorder(
              side: withBorder
                  ? BorderSide(
                      color: AppColors.primaryColor,
                    )
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(6).r,
            ),
          ),
          onPressed: onPressed,
          child: Center(
            child: Row(
              children: [
                const Spacer(),
                if (buttonIcon != null) buttonIcon!,
                if (buttonIcon != null)
                  SizedBox(
                    width: 10.w,
                  ),
                if (label.isNotEmpty)
                  FittedBox(
                    child: Text(
                      label,
                      style: labelStyle ??
                          Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: labelColor, fontSize: 14.0),
                    ),
                  ),
                if (label.isEmpty && labelWidget != null) labelWidget!,
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
