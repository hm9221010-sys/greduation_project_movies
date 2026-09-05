import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greduation_movies_fluter/ui/screens/login/custom_text_field.dart';
import 'package:greduation_movies_fluter/ui/screens/login/no_acc.dart';
import 'package:greduation_movies_fluter/utils/app_color.dart';

import '../../../utils/app_Style.dart';
import '../../../utils/app_size.dart';
import '../../../utils/route_name.dart';
import 'CustomButton.dart';
import 'auth_divider.dart';
import 'language/language_selector.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    bool isPasswordVisible = false;
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.05,
            ),
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
               SizedBox(height: context.height*0.08,),
               CustomTextField(
                   hintText: 'Email',
                   prefixIcon: Icons.email
               ),
               SizedBox(height: context.height * 0.03,),
               CustomTextField(
                 hintText: 'Password',
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
               ),
               SizedBox(
                 height: context.height * 0.001,
               ),
          
               Align(
                 alignment: Alignment.centerRight,
                 child: TextButton(
                   onPressed: () {
                     //todo forgot password
                     Navigator.pushNamed(
                       context,
                       RouteName.forgetPasswordRoute,
                     );
                   },
                   child: Text(
                     ' Forgot Password?',
                     style: AppStyle.regular16Yellow,
                   ),
                 ),
               ),
               SizedBox(height: context.height * 0.025,),
               CustomButton(
                 text: 'Login',
                 onPressed: () {
                   //todo Login logic
                 },
               ),
               SizedBox(height: context.height * 0.025,),
               noAccText(
                 text: "Don't Have Account ? ",
                 actionText: 'Create One',
                 onTap: () {
                   //todo Register Screen
                   Navigator.pushNamed(
                     context,
                     RouteName.registerRoute,
                   );
                 },
               ),
               SizedBox(height: context.height * 0.025,),
               const AuthDivider(),
               SizedBox(height: context.height * 0.025,),
          
            CustomButton(
              text: 'Login With Google',
              icon: Icon(
                Icons.g_mobiledata,
                color: AppColors.blackColor,
                size: context.width * 0.1,
              ),
              onPressed: () {
                //todo Google Sign-In
              },
            ),
               SizedBox(
                 height: context.height * 0.03,
               ),
          
               const Center(
                 child: LanguageSelector(),
               ),
          
            ]
            ),
                ),
        ),
      ),
    );
  }
}