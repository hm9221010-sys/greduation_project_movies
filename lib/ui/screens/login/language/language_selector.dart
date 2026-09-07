import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greduation_movies_fluter/utils/app_size.dart';
import '../../../../utils/app_color.dart';
import 'language_cubit.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.watch<LanguageCubit>().state;

    final isEnglish = currentLocale.languageCode == 'en';
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
                context.read<LanguageCubit>().changeLanguage('en');
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
              context.read<LanguageCubit>().changeLanguage('ar');
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