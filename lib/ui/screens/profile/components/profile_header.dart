import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/utils/app_Style.dart';

import '../../../../l10n/app_localizations.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String userAvatar;
  final int wishListCount;
  final int historyCount;

  const ProfileHeader({
    super.key,
    required this.historyCount,
    required this.wishListCount,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final lang = AppLocalizations.of(context)!;
    debugPrint('User Avatar: $userAvatar');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [

            CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage(userAvatar),
            ),
            SizedBox(
              height: height * 0.008,
            ),
            Text(
              userName,
              style: AppStyle.bold20White,
            ),
          ],
        ),

        Column(
          children: [
            Text(
              wishListCount.toString(),
              style: AppStyle.bold36White,
            ),
            SizedBox(
              height: height * 0.008,
            ),
            Text(
              lang.wishList,
              style: AppStyle.bold24White,
            ),
          ],
        ),

        Column(
          children: [
            Text(
              historyCount.toString(),
              style: AppStyle.bold36White,
            ),
            SizedBox(
              height: height * 0.008,
            ),
            Text(
              lang.history,
              style: AppStyle.bold24White,
            ),
          ],
        ),
      ],
    );
  }
}