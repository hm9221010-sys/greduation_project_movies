import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/ui/screens/forget_password/forget_password.dart';
import 'package:greduation_movies_fluter/ui/screens/login/login_screen.dart';
import 'package:greduation_movies_fluter/ui/screens/onboarding/onboarding_screen.dart';
import 'package:greduation_movies_fluter/ui/screens/register/register_screen.dart';
import 'package:greduation_movies_fluter/utils/route_name.dart';

void main(){
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.onboardingRoute,
      routes: {
        RouteName.onboardingRoute: (context) => OnboardingScreen(),
        RouteName.loginRoute:(context) => LoginScreen(),
        RouteName.forgetPasswordRoute: (context) => ForgetPasswordScreen(),
        RouteName.registerRoute: (context) => RegisterScreen(),
      }

    );
  }
}