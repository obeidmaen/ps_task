import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_soft_app/core/config/app_colors.dart';
import 'package:progress_soft_app/core/config/context_extensions.dart';

class PostCardWidget extends StatelessWidget {
  final String? title;
  final String? body;

  const PostCardWidget({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Card(
        elevation: 3,
        shadowColor: Colors.black45,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.black12)),
        child: Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      style: context.bodyLargeTextStyle15?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                      // overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      body ?? "",
                      style: context.bodyMediumTextStyle,
                      // overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
