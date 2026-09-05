import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/utils/app_Style.dart';

import '../../../../utils/app_size.dart';

class OnboardingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const OnboardingButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.90,
      height: context.height * 0.065,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              context.width * 0.04,
            ),
          ),
        ),
        child: Text(
          text,
          style: AppStyle.semiBold20Black.copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}