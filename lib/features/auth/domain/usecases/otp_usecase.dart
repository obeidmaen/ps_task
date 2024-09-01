import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/config/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class OTPUseCase extends UseCase<User?, PhoneAuthCredential> {
  final BaseAuthRepository _authRepository;

  OTPUseCase({required BaseAuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Either<Failure, User?>> call(PhoneAuthCredential params) async {
    return await _authRepository.checkOtp(params);
  }
}