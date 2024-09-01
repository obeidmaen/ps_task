import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_soft_app/core/config/context_extensions.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_localization.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({
    super.key,
    required this.textLocalKey,
    this.showLogo = true,
  });
  final String textLocalKey;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLogo) ...{
            SizedBox(
              height: 60.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: "logo",
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 222.r,
                  height: 150.r,
                ),
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
          },
          Text(
            AppLocalization.of(context).getTranslatedValues(textLocalKey),
            style: context.headingMediumTextStyle30?.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
