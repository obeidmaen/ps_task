import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_soft_app/core/config/shared_prefs_client.dart';
import 'package:progress_soft_app/core/network/progress_soft_rest.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasource/auth_datasource.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/data/repositories/auth_repository_imp.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/auth_state_changes_usecase.dart';
import '../../features/auth/domain/usecases/get_user_usecase.dart';
import '../../features/auth/domain/usecases/authenticate_usecase.dart';
import '../../features/auth/domain/usecases/otp_usecase.dart';
import '../../features/auth/domain/usecases/save_user_data_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/presentation/bloc/login_bloc.dart';
import '../../features/posts/data/datasource/posts_datasource.dart';
import '../../features/posts/data/repositories/posts_repository_imp.dart';
import '../../features/posts/domain/repositories/posts_repository.dart';
import '../../features/posts/domain/usecases/posts_usecase.dart';
import '../../features/posts/presentation/controller/posts_cubit.dart';
import '../../features/splash_screen/data/datasource/splash_datasource.dart';
import '../../features/splash_screen/data/models/system_configuration_model.dart';
import '../../features/splash_screen/data/repositories/splash_repository_imp.dart';
import '../../features/splash_screen/domain/repositories/splash_repository.dart';
import '../../features/splash_screen/domain/usecases/system_configuration_usecase.dart';
import '../../features/splash_screen/presentation/controller/splash_cubit.dart';
import '../network/firebase_auth_service.dart';
import '../network/firestore_service.dart';

GetIt getIt = GetIt.instance;
final SharedPrefsClient sharedPrefsClient = getIt<SharedPrefsClient>();
SystemConfigurationModel? systemConfig;

List<Gender> genderList = [
  Gender(id: 1, text: "male"),
  Gender(id: 2, text: "female")
];

class DependencyInjectionInit {
  static final DependencyInjectionInit _singleton = DependencyInjectionInit._();

  factory DependencyInjectionInit() => _singleton;

  DependencyInjectionInit._();

  /// Register the Basic Singleton
  Future<void> registerSingletons() async {
    /// create a instance of Shared Prefs classes.
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final SharedPrefsClient sharedPrefsClient =
        SharedPrefsClient(sharedPreferences);

    getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
    getIt.registerLazySingleton<SharedPrefsClient>(() => sharedPrefsClient);

    getIt.registerLazySingleton<Dio>(() => Dio(),
        instanceName: "progressSoftDio");

    final progressSoftRest =
        ProgressSoftRest(getIt.call(instanceName: "progressSoftDio"));
    getIt.registerLazySingleton(() => progressSoftRest);

    getIt.registerLazySingleton<FirestoreService>(() => FirestoreService(),
        instanceName: "FirestoreService");
    getIt.registerLazySingleton<FirebaseAuthService>(
        () => FirebaseAuthService(),
        instanceName: "FirebaseAuthService");

    //
    //
    //Data Sources
    //
    //

    getIt.registerLazySingleton<BaseAuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(
          getIt<FirebaseAuthService>(instanceName: 'FirebaseAuthService'),
          getIt<FirestoreService>(instanceName: 'FirestoreService')),
    );

    getIt.registerLazySingleton<BaseSplashRemoteDataSource>(
      () => SplashRemoteDataSourceImp(
          getIt<FirestoreService>(instanceName: 'FirestoreService')),
    );

    getIt.registerLazySingleton<BasePostsRemoteDataSource>(
      () => PostsRemoteDataSourceImp(progressSoftRest),
    );

    //
    //
    //Repositories
    //
    //

    getIt.registerLazySingleton<BaseAuthRepository>(
      () => AuthRepositoryImp(
          authRemoteDataSource: getIt<BaseAuthRemoteDataSource>()),
    );

    getIt.registerLazySingleton<BaseSplashRepository>(
      () => SplashRepositoryImp(
          splashRemoteDataSource: getIt<BaseSplashRemoteDataSource>()),
    );

    getIt.registerLazySingleton<BasePostsRepository>(
      () => PostsRepositoryImp(
          postsRemoteDataSource: getIt<BasePostsRemoteDataSource>()),
    );

    //
    //
    //UseCases
    //
    //

    getIt.registerLazySingleton<AuthenticateUseCase>(
      () => AuthenticateUseCase(
        authRepository: getIt<BaseAuthRepository>(),
      ),
    );

    getIt.registerLazySingleton<OTPUseCase>(
      () => OTPUseCase(
        authRepository: getIt<BaseAuthRepository>(),
      ),
    );

    getIt.registerLazySingleton<GetUserUseCase>(
      () => GetUserUseCase(
        authRepository: getIt<BaseAuthRepository>(),
      ),
    );

    getIt.registerLazySingleton<SaveUserDataUseCase>(
      () => SaveUserDataUseCase(
        authRepository: getIt<BaseAuthRepository>(),
      ),
    );

    getIt.registerLazySingleton<AuthStateChangesUseCase>(
      () => AuthStateChangesUseCase(
        authRepository: getIt<BaseAuthRepository>(),
      ),
    );

    getIt.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(
        authRepository: getIt<BaseAuthRepository>(),
      ),
    );

    getIt.registerLazySingleton<SystemConfigurationUseCase>(
      () => SystemConfigurationUseCase(
        splashRepository: getIt<BaseSplashRepository>(),
      ),
    );

    getIt.registerLazySingleton<GetPostsUseCase>(
      () => GetPostsUseCase(
        postsRepository: getIt<BasePostsRepository>(),
      ),
    );

    //
    //
    //Bloc
    //
    //

    getIt.registerFactory<LoginBloc>(() => LoginBloc(
          authenticationUseCases: getIt<AuthenticateUseCase>(),
          otpUseCase: getIt<OTPUseCase>(),
          getUserUseCase: getIt<GetUserUseCase>(),
          saveUserDataUseCase: getIt<SaveUserDataUseCase>(),
          authStateChangesUseCase: getIt<AuthStateChangesUseCase>(),
          signOutUseCase: getIt<SignOutUseCase>(),
        ));

    getIt.registerFactory<SplashCubit>(() => SplashCubit(
        systemConfigurationUseCase: getIt<SystemConfigurationUseCase>()));

    getIt.registerFactory<PostsCubit>(
        () => PostsCubit(getPostsUseCase: getIt<GetPostsUseCase>()));
  }
}
