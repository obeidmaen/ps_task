import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/config/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class AuthStateChangesUseCase extends UseCase<void, NoParams> {
  final BaseAuthRepository _authRepository;

  AuthStateChangesUseCase({required BaseAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }

  Stream<User?> authStateChanges() {
    return _authRepository.authStateChanges();
  }
}
