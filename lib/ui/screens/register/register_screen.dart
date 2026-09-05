import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/ui/screens/login/no_acc.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_size.dart';
import '../login/CustomButton.dart';
import '../login/custom_text_field.dart';
import '../profile/avatar/avatar_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
  @override
  Widget build(BuildContext context) {
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
                  height: context.height * 0.04,
                ),
                AvatarPicker(
                  avatars: avatars,
                  selectedAvatar: selectedAvatar,
                  onAvatarSelected: (avatar) {
                    setState(() {
                      selectedAvatar = avatar;
                    });
                  },
                ),
                SizedBox(height: context.height * 0.01,),
                CustomTextField(
                  hintText: 'Name',
                  prefixIcon: Icons.person,
                ),
                SizedBox(
                  height: context.height * 0.02,
                ),
                CustomTextField(
                  hintText: 'Phone Number',
                  prefixIcon: Icons.phone,
                ),
                SizedBox(height: context.height * 0.02,),
                CustomTextField(
                  hintText: 'Email',
                  prefixIcon: Icons.email,
                ),
                SizedBox(
                  height: context.height * 0.02,
                ),

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
                  height: context.height * 0.02,
                ),

                CustomTextField(
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock,
                  obscureText: !isConfirmPasswordVisible,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                    icon: Icon(
                      isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: context.height * 0.03,
                ),

                CustomButton(
                  text: 'Create Account',
                  onPressed: () {
                    //todo Register logic
                  },
                ),
                SizedBox(
                  height: context.height * 0.02,
                ),

                noAccText(
                  text: 'Already Have Account ? ',
                  actionText: 'Login',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}