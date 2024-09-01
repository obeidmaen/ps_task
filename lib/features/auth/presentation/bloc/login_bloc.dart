import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/core/config/injection_container.dart';
import '../../../../core/error/failure.dart';
import '../../../shared/data/models/verify_phone_number_model.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/auth_state_changes_usecase.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/authenticate_usecase.dart';
import '../../domain/usecases/otp_usecase.dart';
import '../../domain/usecases/save_user_data_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<AuthEvent, LoginState> {
  final AuthenticateUseCase _authenticationUseCases;
  final OTPUseCase _otpUseCase;
  final GetUserUseCase _getUserUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;
  final AuthStateChangesUseCase _authStateChangesUseCase;
  final SignOutUseCase _signOutUseCase;
  final GlobalKey<FormState> keyForm =
      GlobalKey<FormState>(debugLabel: 'label28');
  final GlobalKey<FormState> registerForm =
      GlobalKey<FormState>(debugLabel: 'label29');
  final GlobalKey<FormState> otpForm =
      GlobalKey<FormState>(debugLabel: 'label30');
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? verificationId;
  User? currentUser;
  UserModel? loggedInUserData;

  Gender? selectedGender = genderList.first;

  static LoginBloc get(context) => BlocProvider.of<LoginBloc>(context);

  LoginBloc({
    required AuthenticateUseCase authenticationUseCases,
    required OTPUseCase otpUseCase,
    required GetUserUseCase getUserUseCase,
    required SaveUserDataUseCase saveUserDataUseCase,
    required AuthStateChangesUseCase authStateChangesUseCase,
    required SignOutUseCase signOutUseCase,
  })  : _authenticationUseCases = authenticationUseCases,
        _otpUseCase = otpUseCase,
        _getUserUseCase = getUserUseCase,
        _saveUserDataUseCase = saveUserDataUseCase,
        _authStateChangesUseCase = authStateChangesUseCase,
        _signOutUseCase = signOutUseCase,
        super(LoginInitial());

  Future<void> login() async {
    try {
      emit(Loading());
      UserModel? userData = await checkUserExistence();

      if (userData != null) {
        if (userData.hashedPassword ==
            hashPassword(passwordController.text.trim())) {
          loggedInUserData = userData;
          await _login();
        } else {
          emit(WrongPassword());
        }
      }
    } catch (e) {
      emit(const LoginFailed("something_went_wrong"));
    }
  }

  Future<void> _login() async {
    Either<Failure, VerifyPhoneNumberModel?> loginRequest =
        await authenticateUser();

    loginRequest.fold((l) {
      emit(LoginFailed(l.message));
    }, (VerifyPhoneNumberModel? verifyPhoneNumberModel) async {
      // await handleOTPStates(verifyPhoneNumberModel);
    });
  }

  Future<void> signUp() async {
    try {
      emit(Loading());

      UserModel? isUserExists = await checkUserExistence(fromSignUp: true);

      if (isUserExists == null) {
        Either<Failure, VerifyPhoneNumberModel?> verifyPhoneNumberModel =
            await authenticateUser();

        verifyPhoneNumberModel.fold((l) {
          emit(const SignUpFailed("something_went_wrong"));
        }, (r) async {
          // await handleOTPStates(r);
        });
      } else {
        emit(UserAlreadyExists());
      }
    } catch (e) {
      emit(const LoginFailed("something_went_wrong"));
    }
  }

  Future<void> signOut() async {
    await sharedPrefsClient.clearUserData();
    await _signOutUseCase.signOut();
    emit(SignOutSuccess());
  }

  Future<Either<Failure, VerifyPhoneNumberModel?>> authenticateUser() async {
    return await _authenticationUseCases.login(
        AuthParameters(
          userName:
              "${systemConfig?.countryCode}${phoneNumberController.text.trim()}",
          password: passwordController.text.trim(),
        ), (phoneAuthCredential) async {
      await handleOTPStates(
          VerifyPhoneNumberModel(phoneAuthCredential: phoneAuthCredential));
    }, (verificationId, forceResendToken) async {
      await handleOTPStates(
          VerifyPhoneNumberModel(verificationId: verificationId));
    });
  }

  Future<void> handleOTPStates(
      VerifyPhoneNumberModel? verifyPhoneNumberModel) async {
    if (verifyPhoneNumberModel?.phoneAuthCredential != null) {
      var user =
          await sendOTPToFirebase(verifyPhoneNumberModel!.phoneAuthCredential!);
      if (user != null) {
        emit(LoginSuccess());
      } else {
        emit(const LoginFailed("something_went_wrong"));
      }
    } else if (verifyPhoneNumberModel?.verificationId != null) {
      verificationId = verifyPhoneNumberModel!.verificationId!;
      emit(OTPNeeded());
    } else {
      emit(const LoginFailed("something_went_wrong"));
    }
  }

  Future<void> verifyOTP() async {
    if (verificationId != null) {
      emit(Loading());

      var credential = PhoneAuthProvider.credential(
          verificationId: verificationId!, smsCode: otpController.text.trim());

      var user = await sendOTPToFirebase(credential);

      if (user == null) {
        emit(const LoginFailed("something_went_wrong"));
      } else {
        currentUser = user;
        emit(LoginSuccess());
      }
    } else {
      emit(MissingVerificationId());
    }
  }

  Future<User?> sendOTPToFirebase(PhoneAuthCredential credential) async {
    Either<Failure, User?> userData = await _otpUseCase(credential);

    return userData.fold((l) {
      return null;
    }, (User? user) {
      return user;
    });
  }

  Future<UserModel?> checkUserExistence({bool fromSignUp = false}) async {
    try {
      Either<Failure, UserModel?> userData = await _getUserUseCase(
          "${systemConfig?.countryCode}${phoneNumberController.text.trim()}");

      return userData.fold((l) {
        emit(const LoginFailed("something_went_wrong"));
      }, (UserModel? user) async {
        if (user != null) {
          return user;
        } else {
          if (!fromSignUp) {
            emit(UserNotFoundState());
          }
        }
      });
    } catch (e) {
      emit(const LoginFailed("something_went_wrong"));
    }
  }

  Future<void> saveUserData() async {
    emit(Loading());
    Either<Failure, void> data = await _saveUserDataUseCase(UserModel(
      id: currentUser?.uid,
      fullName: fullNameController.text.trim(),
      phoneNumber:
          "${systemConfig?.countryCode}${phoneNumberController.text.trim()}",
      hashedPassword: hashPassword(passwordController.text.trim()),
      age: ageController.text,
      gender: selectedGender?.id,
    ));

    data.fold((l) {
      emit(const LoginFailed("something_went_wrong"));
    }, (r) {
      emit(SignUpSuccess());
    });
  }

  Stream<User?> authStateChanges() {
    return _authStateChangesUseCase.authStateChanges();
  }

  void saveUserDataLocally() {
    sharedPrefsClient.userFullName = loggedInUserData?.fullName ?? "";
    sharedPrefsClient.userAge = loggedInUserData?.age ?? "";
    sharedPrefsClient.userPhoneNumber = loggedInUserData?.phoneNumber ?? "";
    sharedPrefsClient.userGender = loggedInUserData?.gender ?? 1;
  }

  void fillUserData() {
    fullNameController.text = sharedPrefsClient.userFullName;
    ageController.text = sharedPrefsClient.userAge;
    phoneNumberController.text = sharedPrefsClient.userPhoneNumber;
    selectedGender = genderList
        .firstWhere((element) => element.id == sharedPrefsClient.userGender);
  }

  String hashPassword(String password) {
    final bytes = utf8.encode(password);

    final digest = sha256.convert(bytes);

    return digest.toString();
  }

  void updateAgeField(int value) {
    ageController.text = value.toString();
    emit(AgePickerValueChanged());
  }

  void changeSelectedGender(Gender? value) {
    selectedGender = value;
    emit(SelectedGenderChanged());
  }

  resetLoginControllers() {
    fullNameController.clear();
    phoneNumberController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    otpController.clear();
  }
}
