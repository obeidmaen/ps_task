import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final Color? color;
  const CustomLoadingIndicator({
    super.key,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}