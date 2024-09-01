import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_localization.dart';
import '../../../../core/config/injection_container.dart';
import '../../../../core/config/utils.dart';
import '../../../../core/ui/custom_text_field.dart';
import '../bloc/login_bloc.dart';

class FullNameField extends StatelessWidget {
  const FullNameField({
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
            AppLocalization.of(context).getTranslatedValues("full_name"),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        Flexible(
          child: CustomTextField(
            enabled: !fromProfile,
            fillColor: fromProfile ? Colors.grey.shade200 : null,
            icon: Icon(
              Icons.person_rounded,
              size: 24.r,
              color: AppColors.primaryColor,
            ),
            controller: loginController.fullNameController,
            keyboardType: TextInputType.text,
            validator: (String? value) {
              if (systemConfig?.fullNameRegex != null && value != null && value.isNotEmpty) {
                RegExp nameRegExp = RegExp(
                  systemConfig!.fullNameRegex!,
                  caseSensitive: false,
                );
                return nameRegExp.hasMatch(value)
                    ? null
                    : getServiceMessage(
                        enMessage: systemConfig!.fullNameErrorMessageEn,
                        arMessage: systemConfig!.fullNameErrorMessageAr);
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
