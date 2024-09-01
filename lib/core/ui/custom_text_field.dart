import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final TextAlign textAlign;
  final String? hintText;
  final String? helperText;
  final Widget? icon;
  final bool enabled;
  final Widget? label;
  final String? labelText;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final bool enableInteractiveSelection;
  final bool obscureText;
  final bool isPass;
  final TextDirection? textDirection;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onChanged;
  final String? Function(String? value)? onSaved;
  final String? Function(String? value)? onFieldSubmitted;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final FontWeight? fontWeight;

  final EdgeInsetsGeometry? contentPadding;
  final Color? textColor;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final double? borderRadius;
  final double? borderWidth;
  final String? initialValue;
  final Widget? suffixIcon;
  final AutovalidateMode? autoValidateMode;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    this.controller,
    this.suffixIcon,
    this.focusNode,
    this.borderRadius,
    this.borderWidth,
    this.textColor,
    this.fillColor,
    this.keyboardType,
    this.fontWeight,
    this.maxLines,
    this.label,
    this.labelText,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.icon,
    this.hintText,
    this.helperText,
    this.contentPadding,
    this.enabled = true,
    this.enableInteractiveSelection = true,
    this.obscureText = false,
    this.isPass = false,
    this.textDirection,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.padding,
    this.inputFormatters,
    this.initialValue,
    this.autoValidateMode,
    this.textInputAction,
    this.floatingLabelAlignment,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _visiblePassword = false;

  @override
  void initState() {
    _visiblePassword = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      child: TextFormField(
        textInputAction: widget.textInputAction,
        initialValue: widget.initialValue,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: widget.textColor,
            fontWeight: widget.fontWeight,
            fontSize: 14),
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        maxLines: _visiblePassword ? 1 : widget.maxLines,
        maxLength: widget.maxLength,
        textAlign: widget.textAlign,
        autovalidateMode: widget.autoValidateMode,
        // style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          fillColor: widget.fillColor ??
              Colors.transparent,
          filled: true,
          hintText: widget.hintText,
          label: widget.label,
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //fontWeight: FontWeight.w600,
                fontSize: 13.0,
                color: Colors.grey,
              ),
          labelText: widget.labelText,
          floatingLabelAlignment: widget.floatingLabelAlignment,
          alignLabelWithHint: true,
          helperText: widget.helperText,
          contentPadding: widget.contentPadding ??
              (widget.icon != null
                  ? EdgeInsets.zero
                  : EdgeInsetsDirectional.only(
                      start: 15.w, top: 20.h, bottom: 20.h, end: 15.w)),
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: widget.textColor),
          prefixIcon: widget.icon != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0).r,
                  child: widget.icon,
                )
              : null,
          suffixIcon: widget.suffixIcon ??
              (widget.isPass
                  ? GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0).r,
                        child: Icon(
                          _visiblePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                          size: 24.r,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _visiblePassword = !_visiblePassword;
                        });
                      },
                    )
                  : null),
          counterStyle: const TextStyle(fontSize: 0, color: Colors.transparent),
          // suffixIcon: Padding(
          //   padding: EdgeInsets.only(right: 20),
          //   child: icon,
          // ),
          errorMaxLines: 3,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? 6,
            ).r,
            borderSide: BorderSide(
                color: Colors.grey,
                width: widget.borderWidth ?? 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 6)
                .r,
            borderSide: BorderSide(
                color: Colors.grey,
                width: widget.borderWidth ?? 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 6)
                .r,
            borderSide: BorderSide(
                color: Colors.red, width: widget.borderWidth ?? 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 6)
                .r,
            borderSide: BorderSide(
                color: Colors.red, width: widget.borderWidth ?? 1),
          ),
          errorStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.red,
              fontWeight: widget.fontWeight,
              fontSize: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 6)
                .r,
          ),
        ),
        enabled: widget.enabled,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        focusNode: widget.focusNode ??
            (widget.enableInteractiveSelection
                ? null
                : AlwaysDisabledFocusNode()),
        inputFormatters: widget.inputFormatters,
        obscureText: _visiblePassword,
        textDirection: widget.textDirection,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.onFieldSubmitted,
        onTap: widget.onTap,
        onEditingComplete: widget.onEditingComplete,
      ),
    );
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

