import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/config/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../shared/data/models/verify_phone_number_model.dart';
import '../repositories/auth_repository.dart';

class AuthenticateUseCase extends UseCase<VerifyPhoneNumberModel?, AuthParameters> {
  final BaseAuthRepository _authRepository;

  AuthenticateUseCase({required BaseAuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Either<Failure, VerifyPhoneNumberModel?>> call(AuthParameters params) {
    // TODO: implement call
    throw UnimplementedError();
  }

  Future<Either<Failure, VerifyPhoneNumberModel?>> login(AuthParameters params,
  void Function(PhoneAuthCredential) verificationCompleted,
  void Function(String, int?) codeSent) async {
    return await _authRepository.login(params, verificationCompleted, codeSent);
  }
}

class AuthParameters {
  final String userName;
  final String password;

  AuthParameters({required this.userName, required this.password});

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "password": password,
    };
  }
}