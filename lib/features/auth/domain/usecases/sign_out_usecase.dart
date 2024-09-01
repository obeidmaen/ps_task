import 'package:dartz/dartz.dart';
import '../../../../core/config/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class SignOutUseCase extends UseCase<void, NoParams> {
  final BaseAuthRepository _authRepository;

  SignOutUseCase({required BaseAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}
