import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/l10n/app_localizations.dart';
import 'package:greduation_movies_fluter/utils/app_style.dart';
import 'package:greduation_movies_fluter/utils/app_color.dart';

class ProfileActions extends StatelessWidget {
  final VoidCallback onEditProfile;
  final VoidCallback onExit;

  const ProfileActions({
    super.key,
    required this.onEditProfile,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: onEditProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.yellowColor,
              foregroundColor: AppColors.blackColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                lang.editProfile,
                style: AppStyle.regular20Black,
              ),
            ),
          ),
        ),

        SizedBox(
          width: width * 0.012,
        ),

        Expanded(
          child: ElevatedButton(
            onPressed: onExit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.whiteColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lang.exit,
                  style: AppStyle.regular20White,
                ),
                SizedBox(
                  width: width * 0.008,
                ),
                const Icon(
                  Icons.exit_to_app,
                  size: 20,
                  color: AppColors.whiteColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}