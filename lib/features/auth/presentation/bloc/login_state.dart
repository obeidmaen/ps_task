part of 'login_bloc.dart';

abstract class LoginState {
  final String? errorMessage;

  const LoginState({this.errorMessage});
}

class LoginInitial extends LoginState {}

class Loading extends LoginState {}

class SendOTPLoading extends LoginState {}

class SendOtpSuccess extends LoginState {}

class OTPNeeded extends LoginState {}

class MissingVerificationId extends LoginState {}

class AgePickerValueChanged extends LoginState {}

class SelectedGenderChanged extends LoginState {}

class UserAlreadyExists extends LoginState {}

class WrongPassword extends LoginState {}

class UserNotFoundState extends LoginState {}

class LoginFailed extends LoginState {
  const LoginFailed(String errorMessage) : super(errorMessage: errorMessage);
}

class SignUpFailed extends LoginState {
  const SignUpFailed(String errorMessage) : super(errorMessage: errorMessage);
}

class LoginSuccess extends LoginState {}

class SignOutSuccess extends LoginState {}

class SignUpSuccess extends LoginState {}
