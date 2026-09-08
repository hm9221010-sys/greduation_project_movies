import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/l10n/app_localizations.dart';
import 'package:greduation_movies_fluter/utils/app_style.dart';
import 'package:greduation_movies_fluter/utils/app_color.dart';
import 'history_tab.dart';
import 'watch_list_tab.dart';

class ProfileTabs extends StatelessWidget {
  const ProfileTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Column(
      children: [
        TabBar(
          indicatorColor: AppColors.yellowColor,
          indicatorWeight: 4,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.whiteColor,
          unselectedLabelColor: AppColors.whiteColor,
          labelStyle: AppStyle.regular20White,
          tabs: [
            Tab(
              icon: const Icon(
                Icons.format_list_bulleted,
                size: 35,
                color: AppColors.yellowColor,
              ),
              text: lang.watchList,
            ),
            Tab(
              icon: const Icon(
                Icons.folder,
                size: 35,
                color: AppColors.yellowColor,
              ),
              text: lang.history,
            ),
          ],
        ),

        Expanded(
          child: Container(
            color: AppColors.blackColor,
            child: TabBarView(
              children: [
                //todo History
                const WatchListTab(),
                HistoryTab()
              ],
            ),
          ),
        ),
      ],
    );
  }

}