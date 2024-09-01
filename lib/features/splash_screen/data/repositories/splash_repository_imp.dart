import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:progress_soft_app/features/splash_screen/data/models/system_configuration_model.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/splash_repository.dart';
import '../datasource/splash_datasource.dart';

class SplashRepositoryImp implements BaseSplashRepository {
  final BaseSplashRemoteDataSource _splashRemoteDataSource;

  SplashRepositoryImp({required BaseSplashRemoteDataSource splashRemoteDataSource})
      : _splashRemoteDataSource = splashRemoteDataSource;

  @override
  Future<Either<Failure, SystemConfigurationModel?>> getSystemConfig() async {
    try {
      var response =
      await _splashRemoteDataSource.getSystemConfig();

      SystemConfigurationModel? data;

      if (response.data() != null) {
        data = systemConfigurationModelFromJson(response.data());
      }

      return Right(data);
    } catch (e) {
      return Left(InvalidInputFailure(e.toString()));
    }
  }


}
