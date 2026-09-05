import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/utils/app_Style.dart';

class noAccText extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onTap;

  const noAccText({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: AppStyle.regular16White,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: AppStyle.regular16Yellow,
          ),
        ),
      ],
    );
  }
}