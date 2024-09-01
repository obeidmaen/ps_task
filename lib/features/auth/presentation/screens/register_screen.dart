import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:progress_soft_app/core/config/app_colors.dart';
import 'package:progress_soft_app/core/config/context_extensions.dart';
import '../../../../core/app_bloc/app_bloc.dart';
import '../../../../core/config/app_localization.dart';
import '../../../../core/config/injection_container.dart';
import '../../../../core/language_cubit/language_cubit.dart';
import '../../../../core/navigation/app_custom_navigation.dart';
import '../../../../core/ui/conditional_builder.dart';
import '../../../../core/ui/custom_drop_down.dart';
import '../../../../core/ui/custom_loading_indicator.dart';
import '../../../../core/ui/default_button.dart';
import '../bloc/login_bloc.dart';
import '../widgets/age_field.dart';
import '../widgets/banner_section.dart';
import '../widgets/full_name_field.dart';
import '../widgets/password_field.dart';
import '../widgets/phone_number_field.dart';
import 'login_screen.dart';
import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const route = 'RegisterScreen';
  final bool fromProfile;

  const RegisterScreen({super.key, this.fromProfile = false});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late LoginBloc loginController;

  @override
  void initState() {
    loginController = LoginBloc.get(context);
    loginController.resetLoginControllers();

    if (widget.fromProfile) {
      loginController.fillUserData();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: Theme.of(context).appBarTheme.systemOverlayStyle!,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: widget.fromProfile
              ? null
              : IconButton(
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 25).r,
                    child: Icon(LanguageCubit.currentLanguage == 'ar'
                        ? Icons.arrow_forward_ios_rounded
                        : Icons.arrow_back_ios_new_rounded),
                  ),
                  onPressed: () {
                    CustomNavigator.pop();
                  },
                ),
          actions: widget.fromProfile
              ? [
                  InkWell(
                    onTap: () {
                      context.read<AppBloc>().toggleLanguage(
                          LanguageCubit.currentLanguage == 'ar' ? 'en' : 'ar');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12).r,
                      child: Row(
                        children: [
                          Text(
                            AppLocalization.of(context)
                                .getTranslatedValues("change_language"),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          const Icon(
                            Icons.language_rounded,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              : null,
          title: widget.fromProfile
              ? Text(
                  AppLocalization.of(context).getTranslatedValues("profile"),
                  style: context.titleLargeTextStyle20
                      ?.copyWith(color: AppColors.primaryColor),
                )
              : null,
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is OTPNeeded) {
              CustomNavigator.push(OTPScreen.route,
                  arguments: {"context": context});
            }
            if (state is LoginFailed) {
              context.showSnackBar(
                  AppLocalization.of(context)
                      .getTranslatedValues(state.errorMessage ?? ""),
                  color: Colors.redAccent);
            }
            if (state is UserAlreadyExists) {
              context.showSnackBar(
                  AppLocalization.of(context)
                      .getTranslatedValues("user_already_exists"),
                  color: Colors.redAccent);
            }
            if (state is SignOutSuccess) {
              CustomNavigator.push(LoginScreen.route, clean: true);
            }
          },
          builder: (context, state) {
            LoginBloc loginController = LoginBloc.get(context);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15).r,
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Form(
                    key: loginController.registerForm,
                    child: Center(
                      child: Column(
                        children: [
                          if (!widget.fromProfile) ...{
                            const BannerSection(
                              textLocalKey: 'create_account',
                              showLogo: false,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          },
                          FullNameField(
                            loginController: loginController,
                            fromProfile: widget.fromProfile,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AgeField(
                            loginController: loginController,
                            fromProfile: widget.fromProfile,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          PhoneNumberField(
                            loginController: loginController,
                            fromProfile: widget.fromProfile,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomDropDown(
                            label: "gender",
                            isEnabled: !widget.fromProfile,
                            items: genderList
                                .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      AppLocalization.of(context)
                                          .getTranslatedValues(item.text),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    )))
                                .toList(),
                            selectItem: loginController.selectedGender,
                            onChanged: (value) =>
                                loginController.changeSelectedGender(value),
                          ),
                          if (!widget.fromProfile) ...{
                            SizedBox(
                              height: 10.h,
                            ),
                            PasswordField(loginController: loginController),
                            SizedBox(
                              height: 10.h,
                            ),
                            PasswordField(
                              loginController: loginController,
                              isConfirmPassword: true,
                            ),
                            // const Spacer(),
                          },
                          SizedBox(
                            height: 40.h,
                          ),
                          ConditionalBuilder(
                            successWidget: (context) => DefaultButton(
                              buttonColor: widget.fromProfile
                                  ? Colors.red.shade700
                                  : null,
                              withoutWidth: true,
                              label: AppLocalization.of(context)
                                  .getTranslatedValues(widget.fromProfile
                                      ? "sign_out"
                                      : "sign_up"),
                              onPressed: () {
                                if (widget.fromProfile ||
                                    (loginController.registerForm.currentState
                                            ?.validate() ??
                                        false)) {
                                  if (widget.fromProfile) {
                                    loginController.signOut();
                                  } else {
                                    loginController.signUp();
                                  }
                                }
                              },
                            ),
                            fallbackWidget: (context) =>
                                const CustomLoadingIndicator(),
                            condition: state is! Loading,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
