import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/core/config/usecase.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../core/config/injection_container.dart';
import '../../data/models/system_configuration_model.dart';
import '../../domain/usecases/system_configuration_usecase.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required SystemConfigurationUseCase systemConfigurationUseCase,
  })  : _systemConfigurationUseCase = systemConfigurationUseCase,
        super(InitialState());

  final SystemConfigurationUseCase _systemConfigurationUseCase;

  static SplashCubit get(context) => BlocProvider.of<SplashCubit>(context);

  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'label75');

  Future<void> getSystemConfiguration() async {
    Either<Failure, SystemConfigurationModel?> data =
        await _systemConfigurationUseCase(NoParams());

    data.fold((l) {
    }, (SystemConfigurationModel? systemConfigurationModel) async {
      systemConfig = systemConfigurationModel;
    });
  }
}
