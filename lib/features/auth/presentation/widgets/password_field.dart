import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_localization.dart';
import '../../../../core/config/injection_container.dart';
import '../../../../core/config/utils.dart';
import '../../../../core/ui/custom_text_field.dart';
import '../bloc/login_bloc.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.loginController,
    this.isConfirmPassword = false,
  });

  final LoginBloc loginController;
  final bool isConfirmPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            AppLocalization.of(context).getTranslatedValues(isConfirmPassword
                ? "confirmPasswordTextField"
                : "loginPasswordTextField"),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        Flexible(
          child: CustomTextField(
            icon: Icon(
              Icons.lock,
              size: 24.r,
              color: AppColors.primaryColor,
            ),
            controller: isConfirmPassword
                ? loginController.confirmPasswordController
                : loginController.passwordController,
            isPass: true,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            validator: (String? value) {
              if (isConfirmPassword) {
                if (value != null && value.isNotEmpty) {
                  if (loginController.passwordController.text !=
                      loginController.confirmPasswordController.text) {
                    return getServiceMessage(
                        enMessage: systemConfig!.confirmPasswordErrorMessageEn,
                        arMessage: systemConfig!.confirmPasswordErrorMessageAr);
                  }
                } else {
                  return AppLocalization.of(context)
                      .getTranslatedValues("field_is_req");
                }
              } else {
                if (systemConfig?.passwordRegex != null &&
                    value != null &&
                    value.isNotEmpty) {
                  RegExp phoneRegExp = RegExp(
                    systemConfig!.passwordRegex!,
                    caseSensitive: false,
                  );
                  return phoneRegExp.hasMatch(value)
                      ? null
                      : getServiceMessage(
                          enMessage: systemConfig!.passwordErrorMessageEn,
                          arMessage: systemConfig!.passwordErrorMessageAr);
                } else {
                  return AppLocalization.of(context)
                      .getTranslatedValues("field_is_req");
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
