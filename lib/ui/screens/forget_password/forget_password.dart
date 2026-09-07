import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/utils/app_Style.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_size.dart';
import '../login/CustomButton.dart';
import '../login/custom_text_field.dart';
import '../login/language/language_selector.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

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
          child: Column(
            children: [
              SizedBox(height: context.height * 0.03,),

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
                hintText: lang.email,
                prefixIcon: Icons.email,
              ),
              SizedBox(
                height: context.height * 0.025,
              ),

              CustomButton(
                text: lang.verifyEmail,
                onPressed: () {
                  //todo Forget Password logic
                },
              ),
              SizedBox(height: context.height * 0.03,),
              const Center(
                child: LanguageSelector(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}