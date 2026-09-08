import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/ui/screens/login/no_acc.dart';

import '../../../../utils/app_color.dart';
import '../../../firebase_utils.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/route_name.dart';
import '../login/CustomButton.dart';
import '../login/custom_text_field.dart';
import 'avatar_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final List<String> avatars = [
    'assets/images/avatars/avatar_1.png',
    'assets/images/avatars/avatar_2.png',
    'assets/images/avatars/avatar_3.png',
    'assets/images/avatars/avatar_4.png',
    'assets/images/avatars/avatar_5.png',
    'assets/images/avatars/avatar_7.png',
    'assets/images/avatars/avatar_8.png',
    'assets/images/avatars/avatar_9.png',
  ];

  String selectedAvatar = 'assets/images/avatars/avatar_1.png';

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false;

  Future<void> register() async {
    final lang = AppLocalizations.of(context)!;

    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      setState(() {
        isLoading = true;
      });

      final userCredential = await FirebaseUtils.createAccount(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      await FirebaseUtils.saveUserData(
        uid: uid,
        name: name,
        phone: phone,
        email: email,
        avatar: selectedAvatar,
      );
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            lang.accountCreatedSuccessfully,
          ),
        ),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteName.homeRoute,
            (route) => false,
      );

    } on FirebaseAuthException catch (e) {
      String message = lang.registrationFailed;

      if (e.code == 'email-already-in-use') {
        message = lang.emailAlreadyRegistered;
      } else if (e.code == 'weak-password') {
        message = lang.weakPassword;
      } else if (e.code == 'invalid-email') {
        message = lang.invalidEmail;
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
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.03,
            ),
            child: Form(
              key: formKey,
              child: Column(
                spacing: height * 0.02,
                children: [
                  AvatarPicker(
                    avatars: avatars,
                    selectedAvatar: selectedAvatar,
                    onAvatarSelected: (avatar) {
                      setState(() {
                        selectedAvatar = avatar;
                      });
                    },
                  ),

                  CustomTextField(
                    controller: nameController,
                    hintText: lang.name,
                    prefixIcon: Icons.person,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return lang.enterName;
                      }

                      return null;
                    },
                  ),

                  CustomTextField(
                    controller: phoneController,
                    hintText: lang.phoneNumber,
                    prefixIcon: Icons.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return lang.enterPhone;
                      }

                      return null;
                    },
                  ),

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

                  CustomTextField(
                    controller: passwordController,
                    hintText: lang.password,
                    prefixIcon: Icons.lock,
                    obscureText: !isPasswordVisible,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible =
                          !isPasswordVisible;
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

                      if (value.length < 6) {
                        return lang.weakPassword;
                      }

                      return null;
                    },
                  ),

                  CustomTextField(
                    controller: confirmPasswordController,
                    hintText: lang.confirmPassword,
                    prefixIcon: Icons.lock,
                    obscureText: !isConfirmPasswordVisible,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordVisible =
                          !isConfirmPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return lang.enterConfirmPassword;
                      }

                      if (value != passwordController.text) {
                        return lang.passwordsDoNotMatch;
                      }

                      return null;
                    },
                  ),

                  isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                    text: lang.createAccount,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        register();
                      }
                    },
                  ),

                  noAccText(
                    text: lang.alreadyHaveAccount,
                    actionText: lang.login,
                    onTap: () {
                      Navigator.pop(context);
                    },
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