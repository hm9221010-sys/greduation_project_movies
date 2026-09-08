import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/utils/app_Style.dart';
import '../../../firebase_utils.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_size.dart';
import '../login/CustomButton.dart';
import '../login/custom_text_field.dart';
import '../login/language/language_selector.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState
    extends State<ForgetPasswordScreen> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  bool isLoading = false;

  Future<void> resetPassword() async {
    final lang = AppLocalizations.of(context)!;

    final email = emailController.text.trim();

    try {
      setState(() {
        isLoading = true;
      });

      await FirebaseUtils.resetPassword(
        email: email,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            lang.resetPasswordEmailSent,
          ),
        ),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String message = lang.somethingWentWrong;

      if (e.code == 'user-not-found') {
        message = lang.userNotFound;
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
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.yellowColor,
          ),
        ),
        title: Text(
          lang.forgetPassword,
          style: AppStyle.bold20Date.copyWith(
            color: AppColors.yellowColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.05,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: context.height * 0.03,
                ),

                Center(
                  child: Image.asset(
                    'assets/images/Forgot password.png',
                    width: context.width * 0.85,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(
                  height: context.height * 0.03,
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

                SizedBox(
                  height: context.height * 0.025,
                ),

                isLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                  text: lang.verifyEmail,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      resetPassword();
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
    );
  }
}