import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/system_configuration_model.dart';

abstract class BaseSplashRepository{
  Future<Either<Failure, SystemConfigurationModel?>> getSystemConfig();
}
