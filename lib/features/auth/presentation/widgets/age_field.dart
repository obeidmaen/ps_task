import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_localization.dart';
import '../../../../core/config/injection_container.dart';
import '../../../../core/config/utils.dart';
import '../../../../core/ui/custom_dialog.dart';
import '../../../../core/ui/custom_text_field.dart';
import '../bloc/login_bloc.dart';

class AgeField extends StatelessWidget {
  AgeField({
    super.key,
    required this.loginController, required this.fromProfile,
  });

  final LoginBloc loginController;
  final bool fromProfile;

  int _age = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            AppLocalization.of(context).getTranslatedValues("age"),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        Flexible(
          child: InkWell(
            onTap: fromProfile ? null : () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) {
                  return CustomDialog(
                    title: "age",
                    saveButtonOnPressed: () {
                      loginController.updateAgeField(_age);
                    },
                    content: Container(
                      padding: const EdgeInsets.all(10).r,
                      child: StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return NumberPicker(
                          value: _age,
                          minValue: 1,
                          maxValue: 120,
                          onChanged: (value) => setState(() => _age = value),
                        );
                      }),
                    ),
                  );
                },
              );
            },
            child: CustomTextField(
              icon: Icon(
                Icons.calendar_month_rounded,
                size: 24.r,
                color: AppColors.primaryColor,
              ),
              enabled: false,
              fillColor: fromProfile ? Colors.grey.shade200 : null,
              controller: loginController.ageController,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (systemConfig?.ageRegex != null &&
                    value != null &&
                    value.isNotEmpty) {
                  RegExp ageRegExp = RegExp(
                    systemConfig!.ageRegex!,
                    caseSensitive: false,
                  );
                  return ageRegExp.hasMatch(value)
                      ? null
                      : getServiceMessage(
                          enMessage: systemConfig!.ageErrorMessageEn,
                          arMessage: systemConfig!.ageErrorMessageAr);
                } else {
                  return AppLocalization.of(context)
                      .getTranslatedValues("field_is_req");
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
