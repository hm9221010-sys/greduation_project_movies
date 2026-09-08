import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/ui/screens/profile/update_profile.dart';
import 'package:greduation_movies_fluter/utils/app_color.dart';
import 'package:greduation_movies_fluter/utils/app_size.dart';
import '../../../features/favorites/services/favorite_service.dart';
import '../../../features/favorites/services/history_service.dart';
import '../../../firebase_utils.dart';
import '../../../utils/route_name.dart';
import 'components/profile_actions.dart';
import 'components/profile_header.dart';
import 'components/profile_tabs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  String userPhone = '';
  String userAvatar =
      'assets/images/avatars/avatar_1.png';

  bool isLoading = true;

  int wishListCount = 0;
  int historyCount = 0;

  StreamSubscription<
      QuerySnapshot<Map<String, dynamic>>>?
  favoritesSubscription;

  @override
  void initState() {
    super.initState();

    getUserData();
    listenToFavorites();
    listenToHistory();
  }

  void listenToFavorites() {
    favoritesSubscription =
        FavoriteService.getFavorites().listen(
              (snapshot) {
            if (!mounted) return;

            setState(() {
              wishListCount = snapshot.docs.length;
            });

            debugPrint(
              'Favorites Count: ${snapshot.docs.length}',
            );
          },
          onError: (error) {
            debugPrint(
              'Favorites Error: $error',
            );
          },
        );
  }

  Future<void> getUserData() async {
    try {
      final document =
      await FirebaseUtils.getUserData();

      if (!mounted) return;

      final data = document.data();

      setState(() {
        userName = data?['name'] ?? '';
        userPhone = data?['phone'] ?? '';
        userAvatar =
            data?['avatar'] ??
                'assets/images/avatars/avatar_1.png';

        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      debugPrint(
        'Get User Data Error: $e',
      );
    }
  }

  @override
  void dispose() {
    favoritesSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;

    if (isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.profileColor,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.yellowColor,
          ),
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:
        AppColors.profileColor,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.02,
              ),

              //todo Profile Header
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.024,
                ),
                child: ProfileHeader(
                  userName: userName,
                  userAvatar: userAvatar,
                  wishListCount:
                  wishListCount,
                  historyCount:
                  historyCount,
                ),
              ),

              SizedBox(
                height: height * 0.032,
              ),

              //todo Edit Profile + Exit
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.032,
                ),
                child: ProfileActions(
                  onEditProfile: () async {
                    final updatedData =
                    await Navigator.push<
                        Map<String, dynamic>>(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UpdateProfileScreen(
                              currentName:
                              userName,
                              currentPhone:
                              userPhone,
                              currentAvatar:
                              userAvatar,
                            ),
                      ),
                    );

                    if (updatedData != null) {
                      setState(() {
                        userName =
                        updatedData['name'];

                        userPhone =
                        updatedData['phone'];

                        userAvatar =
                        updatedData['avatar'];
                      });
                    }
                  },
                  //todo logout
                  onExit: () async {
                    await FirebaseUtils.logout();

                    if (!context.mounted) return;

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteName.loginRoute,
                          (route) => false,
                    );
                  },
                ),
              ),

              SizedBox(
                height: height * 0.032,
              ),

              //todo Watch List + History
              const Expanded(
                child: ProfileTabs(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void listenToHistory() {
    HistoryService.getHistory().listen(
          (snapshot) {
        if (!mounted) return;

        setState(() {
          historyCount = snapshot.docs.length;
        });
      },
      onError: (error) {
        debugPrint(
          'History Error: $error',
        );
      },
    );
  }
}