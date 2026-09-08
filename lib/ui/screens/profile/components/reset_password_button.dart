import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/utils/app_style.dart';

class ResetPasswordButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ResetPasswordButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          text,
          style: AppStyle.regular20White,
        ),
      ),
    );
  }
}