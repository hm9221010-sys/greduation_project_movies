import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/utils/app_size.dart';
import '../../../../utils/app_color.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.015,
        vertical: context.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(
          context.width * 0.08,
        ),
        border: Border.all(
          color: AppColors.yellowColor,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isEnglish = true;
              });
            },
            child: Container(
              padding: EdgeInsets.all(
                context.width * 0.01,
              ),
              decoration: BoxDecoration(
                color: isEnglish
                    ? AppColors.yellowColor
                    : AppColors.transparentColor,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '🇺🇸',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
          ),

          SizedBox(
            width: context.width * 0.015,
          ),

          GestureDetector(
            onTap: () {
              setState(() {
                isEnglish = false;
              });
            },
            child: Container(
              padding: EdgeInsets.all(
                context.width * 0.01,
              ),
              decoration: BoxDecoration(
                color: !isEnglish
                    ? AppColors.yellowColor
                    : AppColors.transparentColor,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '🇪🇬',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}