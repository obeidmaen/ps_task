import 'package:flutter/material.dart';
import '../config/app_localization.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final void Function()? saveButtonOnPressed;
  final Widget? content;
  final String? yesText;
  const CustomDialog(
      {super.key,
      this.title,
      this.saveButtonOnPressed,
      this.content,
      this.yesText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: title != null
          ? Text(AppLocalization.of(context).getTranslatedValues(title!))
          : null,
      actions: [
        if (saveButtonOnPressed != null)
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              saveButtonOnPressed!();
            },
            child: Text(AppLocalization.of(context)
                .getTranslatedValues(yesText ?? 'save')),
          ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child:
              Text(AppLocalization.of(context).getTranslatedValues('cancel')),
        ),
      ],
      content: content,
    );
  }
}
