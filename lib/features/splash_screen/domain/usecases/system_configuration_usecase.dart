import 'package:dartz/dartz.dart';
import '../../../../core/config/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/system_configuration_model.dart';
import '../repositories/splash_repository.dart';

class SystemConfigurationUseCase extends UseCase<SystemConfigurationModel?, NoParams> {
  final BaseSplashRepository _splashRepository;

  SystemConfigurationUseCase({required BaseSplashRepository splashRepository}) : _splashRepository = splashRepository;

  @override
  Future<Either<Failure, SystemConfigurationModel?>> call(NoParams params) async {
    return await _splashRepository.getSystemConfig();
  }
}