import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_soft_app/core/app_bloc/app_bloc.dart';
import 'package:progress_soft_app/core/config/context_extensions.dart';
import 'package:progress_soft_app/core/language_cubit/language_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/config/app_colors.dart';
import 'core/config/app_localization.dart';
import 'core/config/injection_container.dart';
import 'core/navigation/app_custom_navigation.dart';
import 'features/auth/domain/usecases/auth_state_changes_usecase.dart';
import 'features/auth/domain/usecases/get_user_usecase.dart';
import 'features/auth/domain/usecases/authenticate_usecase.dart';
import 'features/auth/domain/usecases/otp_usecase.dart';
import 'features/auth/domain/usecases/save_user_data_usecase.dart';
import 'features/auth/domain/usecases/sign_out_usecase.dart';
import 'features/auth/presentation/bloc/login_bloc.dart';
import 'features/splash_screen/presentation/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppBloc(getIt())),
        BlocProvider(
          create: (_) => LanguageCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => LoginBloc(
            authenticationUseCases: getIt<AuthenticateUseCase>(),
            otpUseCase: getIt<OTPUseCase>(),
            getUserUseCase: getIt<GetUserUseCase>(),
            saveUserDataUseCase: getIt<SaveUserDataUseCase>(),
            authStateChangesUseCase: getIt<AuthStateChangesUseCase>(),
            signOutUseCase: getIt<SignOutUseCase>(),
          ),
          lazy: false,
        )
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        buildWhen: (previousState, currentState) =>
            previousState != currentState,
        builder: (_, localeState) {
          return ScreenUtilInit(
            splitScreenMode: true,
            minTextAdapt: true,
            designSize: const Size(428, 926),
            builder: (BuildContext context, Widget? child) => GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.focusedChild?.unfocus();
                }
              },
              child: MaterialApp(
                title: 'ProgressSoft',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  useMaterial3: true,
                  primarySwatch: AppColors.primaryColor,
                  primaryColor: AppColors.primaryColor,
                  scaffoldBackgroundColor: Colors.white,
                  cardColor: Colors.white,
                  colorScheme: ColorScheme.fromSwatch(
                          primarySwatch: AppColors.primaryColor)
                      .copyWith(
                          secondary: AppColors.primaryColor.shade700,
                          brightness: Brightness.light),
                  dividerTheme:
                      const DividerThemeData(color: AppColors.divider),
                  appBarTheme: AppBarTheme(
                    centerTitle: true,
                    iconTheme: IconThemeData(color: AppColors.primaryColor, size: 25.r),
                    backgroundColor: Colors.white,
                    titleTextStyle: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: AppColors.primaryColor,
                      statusBarIconBrightness: Brightness.light,
                      systemNavigationBarColor: AppColors.primaryColor,
                      systemNavigationBarIconBrightness: Brightness.light,
                    ),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    unselectedIconTheme: IconThemeData(
                      color: AppColors.greyLogo,
                      size: 24.r,
                    ),
                    selectedIconTheme: IconThemeData(
                      color: AppColors.primaryColor,
                      size: 24.r,
                    ),
                    backgroundColor: Colors.white,
                    unselectedLabelStyle: context.labelLargeTextStyle13?.copyWith(color: AppColors.greyLogo),
                    showUnselectedLabels: true,
                    showSelectedLabels: true,
                    selectedLabelStyle: context.labelLargeTextStyle13?.copyWith(color: AppColors.primaryColor),
                    type: BottomNavigationBarType.fixed,
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,)
                  ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryColor,)
                  )
                ),
                locale: localeState.locale,
                navigatorKey: CustomNavigator.navigatorState,
                onGenerateRoute: CustomNavigator.onCreateRoute,
                initialRoute: SplashScreen.route,
                navigatorObservers: [CustomNavigator.routeObserver],
                localizationsDelegates: const [
                  AppLocalization.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('ar', ''),
                  Locale('en', ''),
                ],
                // home: const ,
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const route = 'MyHomePage';
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          // title: Text(widget.title),
          ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
