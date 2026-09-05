import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/utils/app_Style.dart';
import 'package:greduation_movies_fluter/utils/app_size.dart';
import '../../../utils/app_color.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.yellowColor,
            thickness: 1,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.03,
          ),
          child: Text(
            'OR',
            style: AppStyle.regular16Yellow,
          ),
        ),

        const Expanded(
          child: Divider(
            color: AppColors.yellowColor,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}