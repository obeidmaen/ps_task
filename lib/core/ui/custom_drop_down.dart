import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_soft_app/core/config/context_extensions.dart';

import '../config/app_colors.dart';
import '../config/app_localization.dart';

class CustomDropDown<T> extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Color? color;
  final String hint;
  final Color? borderColor;
  final TextStyle? textStyle;
  final bool? isExpanded;
  final bool isEnabled;
  final List<DropdownMenuItem<T>> items;
  final T? selectItem;
  final void Function(T?)? onChanged;
  final FormFieldValidator<T>? validator;
  final BoxDecoration? decoration;
  final double? borderWidth;
  final String? label;
  final bool isOptional;
  final dynamic defaultValue;

  const CustomDropDown(
      {this.borderWidth,
      this.decoration,
      this.defaultValue,
      super.key,
      this.textStyle,
      required this.items,
      required this.selectItem,
      this.onChanged,
      this.borderColor,
      this.hint = "",
      this.color,
      this.width,
      this.height,
      this.margin,
      this.isExpanded,
      this.isEnabled = true,
      this.padding,
      this.validator,
      this.label,
      this.isOptional = false});

  @override
  Widget build(BuildContext context) {
    if (defaultValue != null &&
        items.where((element) => element.value == -1).isEmpty) {
      items.insert(
          0,
          DropdownMenuItem(
            value: defaultValue,
            child: Text(
              AppLocalization.of(context).getTranslatedValues('all'),
            ),
          ));
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 7.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null)
            Padding(
              padding: EdgeInsets.only(bottom: 7.h),
              child: Text(
                AppLocalization.of(context).getTranslatedValues(label!),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          IgnorePointer(
            ignoring: !isEnabled,
            child: Container(
              decoration: !isEnabled
                  ? BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6).r,
                    )
                  : BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        const Radius.circular(6).r,
                      ),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(13.w, 15.h, 13.w, 15.h),
                child: DropdownButtonFormField<T>(
                  validator: validator,
                  decoration: InputDecoration.collapsed(hintText: "").copyWith(
                    errorStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.red, fontSize: 10),
                  ),
                  // InputDecoration(
                  //   contentPadding: const EdgeInsets.symmetric(
                  //     horizontal: AppConstants.dropDownPadding,
                  //   ).r,
                  //   border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(AppConstants.radius50).r,
                  //     borderSide: const BorderSide(
                  //       color: AppColors.grey,
                  //     ),
                  //   ),
                  //   enabledBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(AppConstants.radius50).r,
                  //     borderSide: const BorderSide(
                  //       color: AppColors.grey,
                  //     ),
                  //   ),
                  //   focusedBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(AppConstants.radius50).r,
                  //     borderSide: const BorderSide(
                  //       color: AppColors.grey,
                  //     ),
                  //   ),
                  // ),
                  dropdownColor: Colors.white,
                  isExpanded: isExpanded ?? false,
                  style: textStyle ?? context.bodyMediumTextStyle,
                  value: selectItem,
                  items: items,
                  hint: Wrap(
                    children: [
                      Text(
                        hint,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                      )
                    ],
                  ),
                  icon: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 5.0),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 25.r,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
