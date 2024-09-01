import 'package:dartz/dartz.dart';
import '../../../../core/config/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

class GetUserUseCase extends UseCase<UserModel?, String?> {
  final BaseAuthRepository _authRepository;

  GetUserUseCase({required BaseAuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserModel?>> call(String? params) async {
    return await _authRepository.getUserByPhoneNumber(params);
  }
}