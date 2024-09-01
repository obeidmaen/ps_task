import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_soft_app/core/app_bloc/app_bloc.dart';
import 'package:progress_soft_app/core/config/app_colors.dart';
import 'package:progress_soft_app/core/config/context_extensions.dart';
import 'package:progress_soft_app/core/config/injection_container.dart';
import 'package:progress_soft_app/core/config/utils.dart';
import 'package:progress_soft_app/core/language_cubit/language_cubit.dart';
import 'package:progress_soft_app/features/auth/presentation/screens/register_screen.dart';
import '../../../../core/config/app_localization.dart';
import '../../../../core/navigation/app_custom_navigation.dart';
import '../../../../core/ui/conditional_builder.dart';
import '../../../../core/ui/custom_dialog.dart';
import '../../../../core/ui/custom_loading_indicator.dart';
import '../../../../core/ui/default_button.dart';
import '../bloc/login_bloc.dart';
import '../widgets/banner_section.dart';
import '../widgets/password_field.dart';
import '../widgets/phone_number_field.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  static const route = 'LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginController;

  @override
  void initState() {
    loginController = LoginBloc.get(context);
    loginController.resetLoginControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: Theme.of(context).appBarTheme.systemOverlayStyle!,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is OTPNeeded) {
              CustomNavigator.push(OTPScreen.route,
                  arguments: {"context": context, "fromLogin": true});
            }
            if (state is WrongPassword) {
              context.showSnackBar(
                  getServiceMessage(
                      enMessage: systemConfig?.incorrectPasswordEn,
                      arMessage: systemConfig?.incorrectPasswordAr),
                  color: Colors.redAccent);
            }
            if (state is LoginFailed) {
              context.showSnackBar(
                  AppLocalization.of(context)
                      .getTranslatedValues(state.errorMessage ?? ""),
                  color: Colors.redAccent);
            }
            if (state is UserNotFoundState) {
              showDialog(
                context: currentContext!,
                builder: (ctx) => CustomDialog(
                  title: AppLocalization.of(context)
                      .getTranslatedValues("no_user"),
                  yesText: "register",
                  saveButtonOnPressed: () {
                    CustomNavigator.push(RegisterScreen.route);
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            LoginBloc loginController = LoginBloc.get(context);

            return CustomScrollView(slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(15).r,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Form(
                      key: loginController.keyForm,
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 50.h,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<AppBloc>().toggleLanguage(
                                          LanguageCubit.currentLanguage == 'ar'
                                              ? 'en'
                                              : 'ar');
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          AppLocalization.of(context)
                                              .getTranslatedValues(
                                                  "change_language"),
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
                                ],
                              ),
                            ),
                            const BannerSection(
                              textLocalKey: 'loginButton',
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            PhoneNumberField(
                              loginController: loginController,
                              fromProfile: false,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            PasswordField(loginController: loginController),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    CustomNavigator.push(RegisterScreen.route);
                                  },
                                  child: Text(
                                    AppLocalization.of(context)
                                        .getTranslatedValues("register"),
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                            // const Spacer(),
                            SizedBox(
                              height: 80.h,
                            ),
                            ConditionalBuilder(
                              successWidget: (context) => DefaultButton(
                                withoutWidth: true,
                                label: AppLocalization.of(context)
                                    .getTranslatedValues("loginButton"),
                                onPressed: () {
                                  if (loginController.keyForm.currentState
                                          ?.validate() ??
                                      false) {
                                    loginController.login();
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
              ),
            ]);
          },
        ),
      ),
    );
  }
}
