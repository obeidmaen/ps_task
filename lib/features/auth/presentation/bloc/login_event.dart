part of 'login_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class Authenticate extends AuthEvent {
  final String password;
  final String username;

  const Authenticate({required this.username, required this.password,});
}

class ResendOTP extends AuthEvent {
  final String username;

  const ResendOTP({required this.username});
}

class ForgetPasswordResendOTPEvent extends AuthEvent {
  final String username;

  const ForgetPasswordResendOTPEvent({required this.username});
}

class ResetPassword extends AuthEvent {
  final String password;
  final String confirmPassword;

  const ResetPassword({required this.password, required this.confirmPassword});
}

class VerifyEmail extends AuthEvent {
  final String email;

  const VerifyEmail({required this.email,});
}

class SendOTP extends AuthEvent {
  final String otp;
  final String email;
  final BuildContext context;

  const SendOTP({required this.otp, required this.email,required this.context,});
}

class SubmitForgetPasswordOTP extends AuthEvent {
  final String otp;
  final String email;
  final BuildContext context;

  const SubmitForgetPasswordOTP({required this.otp, required this.email,required this.context,});
}


class AuthenticateUsingBiometrics extends AuthEvent {}

class SaveLoginData extends AuthEvent {
  final String privateKey;

  const SaveLoginData(
      {required this.privateKey,});
}
