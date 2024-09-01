import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_soft_app/core/config/injection_container.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_localization.dart';
import '../../../../core/config/utils.dart';
import '../../../../core/ui/custom_text_field.dart';
import '../bloc/login_bloc.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
    required this.loginController, required this.fromProfile,
  });

  final LoginBloc loginController;
  final bool fromProfile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            AppLocalization.of(context)
                .getTranslatedValues("loginUserNameTextField"),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        Flexible(
          child: CustomTextField(
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Icon(
                    Icons.phone,
                    size: 24.r,
                    color: AppColors.primaryColor,
                  ),
                ),
                if (systemConfig?.countryCode != null && !fromProfile) ...{
                  SizedBox(
                    width: 16.w,
                  ),
                  Flexible(
                      child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(systemConfig?.countryCode ?? ""),
                  )),
                }
              ],
            ),
            enabled: !fromProfile,
            fillColor: fromProfile ? Colors.grey.shade200 : null,
            controller: loginController.phoneNumberController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (String? value) {
              if (systemConfig?.phoneRegex != null &&
                  value != null &&
                  value.isNotEmpty) {
                RegExp phoneRegExp = RegExp(
                  systemConfig!.phoneRegex!,
                  caseSensitive: false,
                );
                return phoneRegExp.hasMatch(value)
                    ? null
                    : getServiceMessage(
                        enMessage: systemConfig!.phoneErrorMessageEn,
                        arMessage: systemConfig!.phoneErrorMessageAr);
              } else {
                return AppLocalization.of(context)
                    .getTranslatedValues("field_is_req");
              }
            },
          ),
        ),
      ],
    );
  }
}
