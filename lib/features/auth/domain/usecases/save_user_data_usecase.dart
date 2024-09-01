import 'package:dartz/dartz.dart';
import '../../../../core/config/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

class SaveUserDataUseCase extends UseCase<void, UserModel> {
  final BaseAuthRepository _authRepository;

  SaveUserDataUseCase({required BaseAuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(UserModel params) async {
    return await _authRepository.saveUserData(params);
  }
}