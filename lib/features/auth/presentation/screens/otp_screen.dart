import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:progress_soft_app/core/config/context_extensions.dart';
import 'package:progress_soft_app/core/navigation/app_custom_navigation.dart';
import 'package:progress_soft_app/features/auth/presentation/screens/login_screen.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_localization.dart';
import '../../../../core/config/injection_container.dart';
import '../../../../core/ui/conditional_builder.dart';
import '../../../../core/ui/custom_loading_indicator.dart';
import '../../../../core/ui/default_button.dart';
import '../../../posts/presentation/screens/posts_navigation_screen.dart';
import '../bloc/login_bloc.dart';

class OTPScreen extends StatelessWidget {
  static const route = 'OTPScreen';

  final bool fromLogin;

  const OTPScreen({super.key, this.fromLogin = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppLocalization.of(context).getTranslatedValues("otpAppBar"),
          style: TextStyle(color: AppColors.primaryColor),
        ),
      ),
      body: OTPForm(fromLogin: fromLogin),
    );
  }
}

class OTPForm extends StatefulWidget {
  final bool fromLogin;
  const OTPForm({super.key, required this.fromLogin});

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  @override
  Widget build(BuildContext context) {
    LoginBloc loginController = LoginBloc.get(context);
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is SignUpSuccess) {
          loginController.otpController.clear();
          context.showSnackBar(
              AppLocalization.of(context)
                  .getTranslatedValues("user_registered"),
              color: AppColors.primaryColor);
          CustomNavigator.push(LoginScreen.route, clean: true);
        }
        if (state is LoginSuccess) {
          if (widget.fromLogin) {
            loginController.saveUserDataLocally();
            CustomNavigator.push(PostsNavigationScreen.route, clean: true);
          } else {
            await loginController.saveUserData();
            loginController.otpController.clear();
          }
        }
        if (state is MissingVerificationId) {
          context.showSnackBar(
              AppLocalization.of(context)
                  .getTranslatedValues("something_went_wrong"),
              color: Colors.red);
        }
      },
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(
                  15,
                ),
                child: GestureDetector(
                  onTap: context.unFocusKeyboard,
                  child: Form(
                    key: loginController.otpForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        OtpTitleAndPhoneNumber(
                          loginController: loginController,
                        ),
                        const Spacer(),
                        OtpNumberInput(loginController: loginController),
                        const Spacer(
                          flex: 3,
                        ),
                        OtpValidateButton(
                          loginController: loginController,
                          state: state,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class OtpTitleAndPhoneNumber extends StatelessWidget {
  const OtpTitleAndPhoneNumber({
    super.key,
    required this.loginController,
  });

  final LoginBloc loginController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalization.of(context).getTranslatedValues("otpSubmit"),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 25.0.h),
        Text(
          AppLocalization.of(context).getTranslatedValues("enterTheCode"),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 14.0,
              ),
        ),
        SizedBox(height: 16.0.h),
        Text(
          "${systemConfig?.countryCode}${loginController.phoneNumberController.text.trim()}",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 12.0,
              ),
        ),
      ],
    );
  }
}

class OtpNumberInput extends StatelessWidget {
  const OtpNumberInput({
    super.key,
    required this.loginController,
  });

  final LoginBloc loginController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: loginController.otpController,
        length: 6,
        defaultPinTheme: PinTheme(
          width: 60.r,
          height: 70.r,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: AppColors.primaryColor,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        onCompleted: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
          if (loginController.otpForm.currentState?.validate() ?? false) {
            loginController.verifyOTP();
          }
        },
        validator: (String? value) {
          if (value == null || value.isEmpty || value.length < 6) {
            return AppLocalization.of(context)
                .getTranslatedValues("this_field_is_required");
          }
          return null;
        },
        errorTextStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.red, fontSize: 10),
      ),
    );
  }
}

class OtpValidateButton extends StatelessWidget {
  final LoginState state;
  final LoginBloc loginController;

  const OtpValidateButton({
    super.key,
    required this.loginController,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      successWidget: (context) => DefaultButton(
        label: AppLocalization.of(context).getTranslatedValues("otpSubmit"),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (loginController.otpForm.currentState?.validate() ?? false) {
            loginController.verifyOTP();
          }
        },
      ),
      fallbackWidget: (context) => const CustomLoadingIndicator(),
      condition: state is! Loading,
    );
  }
}
