import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/l10n/app_localizations.dart';
import 'package:greduation_movies_fluter/utils/app_Style.dart';
import 'package:greduation_movies_fluter/utils/app_color.dart';

Future<bool> showDeleteAccountDialog(
    BuildContext context,
    ) async {
  final lang = AppLocalizations.of(context)!;

  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        backgroundColor: AppColors.greyColor,
        title: Text(
          lang.deleteAccount,
          style: AppStyle.regular20White,
        ),
        content: Text(
          lang.deleteAccountConfirmation,
          style: AppStyle.regular16White,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(
                dialogContext,
                false,
              );
            },
            child: Text(
              lang.cancel,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(
                dialogContext,
                true,
              );
            },
            child: Text(
              lang.deleteAccount,
              style: const TextStyle(
                color: AppColors.redColor,
              ),
            ),
          ),
        ],
      );
    },
  );

  return result ?? false;
}