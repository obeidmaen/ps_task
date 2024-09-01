import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:progress_soft_app/features/posts/presentation/controller/posts_cubit.dart';
import 'package:progress_soft_app/features/splash_screen/presentation/controller/splash_cubit.dart';

import '../../features/auth/domain/usecases/auth_state_changes_usecase.dart';
import '../../features/auth/domain/usecases/get_user_usecase.dart';
import '../../features/auth/domain/usecases/authenticate_usecase.dart';
import '../../features/auth/domain/usecases/otp_usecase.dart';
import '../../features/auth/domain/usecases/save_user_data_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/posts/domain/usecases/posts_usecase.dart';
import '../../features/posts/presentation/screens/posts_navigation_screen.dart';
import '../../features/splash_screen/presentation/screens/splash_screen.dart';
import '../../my_app.dart';
import '../config/injection_container.dart';

/// Global Context of The App
BuildContext? get currentContext =>
    CustomNavigator.navigatorState.currentContext;

class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>(debugLabel: 'label1');

  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    Map<String, dynamic> data = settings.arguments != null
        ? settings.arguments as Map<String, dynamic>
        : {};

    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => getIt<SplashCubit>(),
                  child: const SplashScreen(),
                ));
      case MyHomePage.route:
        return MaterialPageRoute(builder: (_) => const MyHomePage());
      case LoginScreen.route:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case PostsNavigationScreen.route:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) =>
                    PostsCubit(getPostsUseCase: getIt<GetPostsUseCase>()),
                child: const PostsNavigationScreen()));
      case RegisterScreen.route:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => LoginBloc(
                    authenticationUseCases: getIt<AuthenticateUseCase>(),
                    otpUseCase: getIt<OTPUseCase>(),
                    getUserUseCase: getIt<GetUserUseCase>(),
                    saveUserDataUseCase: getIt<SaveUserDataUseCase>(),
                    authStateChangesUseCase: getIt<AuthStateChangesUseCase>(),
                    signOutUseCase: getIt<SignOutUseCase>(),
                  ),
                  child: const RegisterScreen(),
                ));
      case OTPScreen.route:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: LoginBloc.get(data['context']),
                  child: OTPScreen(
                    fromLogin: data['fromLogin'] ?? false,
                  ),
                ));
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }

  static void pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static push(
    String routeName, {
    arguments,
    bool replace = false,
    bool clean = false,
    bool Function(Route<dynamic>)? predicate,
  }) {
    if (navigatorState.currentState != null) {
      if (clean) {
        return navigatorState.currentState!.pushNamedAndRemoveUntil(
          routeName,
          predicate ?? (_) => false,
          arguments: arguments,
        );
      } else if (replace) {
        return navigatorState.currentState!
            .pushReplacementNamed(routeName, arguments: arguments);
      } else {
        return navigatorState.currentState!
            .pushNamed(routeName, arguments: arguments);
      }
    }
  }
}
