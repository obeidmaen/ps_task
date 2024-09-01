import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_soft_app/core/config/app_colors.dart';
import 'package:progress_soft_app/core/config/context_extensions.dart';
import 'package:progress_soft_app/core/config/injection_container.dart';
import 'package:progress_soft_app/features/auth/presentation/screens/login_screen.dart';
import '../../../../core/config/app_localization.dart';
import '../../../../core/navigation/app_custom_navigation.dart';
import '../../../posts/presentation/screens/posts_navigation_screen.dart';
import '../controller/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  static const route = 'splashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashCubit controller;
  @override
  void initState() {
    super.initState();

    controller = SplashCubit.get(context);

    controller.getSystemConfiguration();

    Future.delayed(const Duration(seconds: 2), () async {
      if (sharedPrefsClient.userPhoneNumber.isNotEmpty) {
        CustomNavigator.push(PostsNavigationScreen.route, clean: true);
      } else {
        CustomNavigator.push(LoginScreen.route, clean: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return splashScreen(context);
  }
}

Widget splashScreen(BuildContext context) {
  return Scaffold(
    body: SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            // Clip it cleanly.
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(30.w),
                    child: Align(
                      alignment: Alignment.center,
                      child: Hero(
                        tag: "logo",
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 300.r,
                          // height: 160.r,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: AppColors.primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: SizedBox(
                              width: 400.w,
                              child: Text(
                                AppLocalization.of(context)
                                    .getTranslatedValues("all_rights_reserved"),
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: context.labelSmallTextStyle
                                    ?.copyWith(color: AppColors.greyLogo),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
