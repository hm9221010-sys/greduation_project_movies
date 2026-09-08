import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/utils/app_Style.dart';
import 'package:greduation_movies_fluter/utils/app_size.dart';

import '../../../utils/app_color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Widget? child;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.child,
    this.backgroundColor = AppColors.yellowColor,
    this.foregroundColor = AppColors.blackColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.height * 0.065,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              context.width * 0.04,
            ),
          ),
        ),
        child: child ??
            (icon == null
                ? Text(
              text,
              style: foregroundColor == AppColors.whiteColor
                  ? AppStyle.regular20White
                  : AppStyle.semiBold20Black,
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon!,
                SizedBox(
                  width: context.width * 0.025,
                ),
                Text(
                  text,
                  style: foregroundColor == AppColors.whiteColor
                      ? AppStyle.regular20White
                      : AppStyle.semiBold20Black,
                ),
              ],
            )),
      ),
    );
  }
}