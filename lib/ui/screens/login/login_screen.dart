import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/ui/screens/login/custom_text_field.dart';
import 'package:greduation_movies_fluter/ui/screens/login/no_acc.dart';
import 'package:greduation_movies_fluter/utils/app_color.dart';

import '../../../firebase_utils.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/app_Style.dart';
import '../../../utils/app_size.dart';
import '../../../utils/route_name.dart';
import 'CustomButton.dart';
import 'auth_divider.dart';
import 'language/language_selector.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isLoading = false;

  Future<void> login() async {
    final lang = AppLocalizations.of(context)!;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      setState(() {
        isLoading = true;
      });

      await FirebaseUtils.login(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteName.homeRoute,
            (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      String message = lang.loginFailed;

      if (e.code == 'user-not-found') {
        message = lang.userNotFound;
      } else if (e.code == 'wrong-password') {
        message = lang.wrongPassword;
      } else if (e.code == 'invalid-email') {
        message = lang.invalidEmail;
      } else if (e.code == 'invalid-credential') {
        message = lang.invalidEmailOrPassword;
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            lang.somethingWentWrong,
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.05,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: context.height * 0.06,
                  ),

                  Center(
                    child: Image.asset(
                      'assets/images/login.png',
                      width: context.width * 0.28,
                    ),
                  ),

                  SizedBox(
                    height: context.height * 0.08,
                  ),

                  //todo Email
                  CustomTextField(
                    controller: emailController,
                    hintText: lang.email,
                    prefixIcon: Icons.email,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return lang.enterEmail;
                      }

                      if (!value.contains('@')) {
                        return lang.invalidEmail;
                      }

                      return null;
                    },
                  ),

                  SizedBox(
                    height: context.height * 0.03,
                  ),

                  // Password
                  CustomTextField(
                    controller: passwordController,
                    hintText: lang.password,
                    prefixIcon: Icons.lock,
                    obscureText: !isPasswordVisible,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return lang.enterPassword;
                      }

                      return null;
                    },
                  ),

                  SizedBox(
                    height: context.height * 0.001,
                  ),

                  //todo Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RouteName.forgetPasswordRoute,
                        );
                      },
                      child: Text(
                        lang.forgotPassword,
                        style: AppStyle.regular16Yellow,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: context.height * 0.025,
                  ),
                  //todo Login
                  isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                    text: lang.login,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        login();
                      }
                    },
                  ),

                  SizedBox(
                    height: context.height * 0.025,
                  ),

                  //todo Register
                  noAccText(
                    text: lang.dontHaveAccount,
                    actionText: lang.createOne,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteName.registerRoute,
                      );
                    },
                  ),

                  SizedBox(
                    height: context.height * 0.025,
                  ),

                  const AuthDivider(),

                  SizedBox(
                    height: context.height * 0.025,
                  ),

                  //todo Google Login
                  CustomButton(
                    text: lang.loginWithGoogle,
                    icon: Icon(
                      Icons.g_mobiledata,
                      color: AppColors.blackColor,
                      size: context.width * 0.1,
                    ),
                    onPressed: () async{
                      // TODO: Google Sign-In
                      try {
                        final userCredential =
                            await FirebaseUtils.signInWithGoogle();

                        if (!mounted) return;

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteName.homeRoute,
                              (route) => false,
                        );
                      } catch (e) {
                        debugPrint('Google Sign-In Error: $e');

                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                  ),

                  SizedBox(
                    height: context.height * 0.03,
                  ),

                  const Center(
                    child: LanguageSelector(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}