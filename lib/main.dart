import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/home/presentation/views/main_view.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'ui/screens/forget_password/forget_password.dart';
import 'ui/screens/login/language/language_cubit.dart';
import 'ui/screens/login/login_screen.dart';
import 'ui/screens/onboarding/onboarding_screen.dart';
import 'ui/screens/register/register_screen.dart';
import 'utils/route_name.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    BlocProvider(
      create: (context) => LanguageCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return ScreenUtilInit(
      designSize: const Size(
        430,
        932,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<LanguageCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              locale: locale,

              localizationsDelegates:
              AppLocalizations.localizationsDelegates,

              supportedLocales:
              AppLocalizations.supportedLocales,

              initialRoute: user != null
                  ? RouteName.homeRoute
                  : RouteName.onboardingRoute,

              routes: {
                RouteName.onboardingRoute: (context) =>
                const OnboardingScreen(),

                RouteName.loginRoute: (context) =>
                    LoginScreen(),

                RouteName.forgetPasswordRoute: (context) =>
                const ForgetPasswordScreen(),

                RouteName.registerRoute: (context) =>
                const RegisterScreen(),

                RouteName.homeRoute: (context) =>
                const MainView(),
              },
            );
          },
        );
      },
    );
  }
}