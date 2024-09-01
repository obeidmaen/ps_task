// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class ConditionalBuilder extends StatelessWidget {
  bool condition;
  final Widget Function(BuildContext) successWidget;
  final Widget Function(BuildContext) fallbackWidget;

  ConditionalBuilder(
      {super.key,
        required this.successWidget,
        required this.fallbackWidget,
        required this.condition});

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return successWidget(context);
    } else {
      return fallbackWidget(context);
    }
  }
}
