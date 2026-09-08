import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/utils/app_Style.dart';
import 'package:greduation_movies_fluter/utils/app_size.dart';
import '../../../utils/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      style: AppStyle.regular16White,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyle.regular16White,

        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.whiteColor,
        ),

        suffixIcon: suffixIcon,

        filled: true,
        fillColor: AppColors.greyColor,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            context.width * 0.04,
          ),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            context.width * 0.04,
          ),
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            context.width * 0.04,
          ),
          borderSide: const BorderSide(
            color: AppColors.yellowColor,
          ),
        ),
      ),
    );
  }
}