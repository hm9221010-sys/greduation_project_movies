import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/ui/profile/update_profile.dart';
import 'package:greduation_movies_fluter/utils/app_Style.dart';
import 'package:greduation_movies_fluter/utils/app_color.dart';
import 'package:greduation_movies_fluter/utils/app_size.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'John Safwat';
  String userPhone = '01200000000';
  String userAvatar = '/Users/shawky/Desktop/greduation_movies_fluter/assets/images/avatar8.png';

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.profileColor,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: height * 0.04),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.024),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundImage: AssetImage(userAvatar),
                        ),
                        SizedBox(height: height * 0.008),
                        Text(
                          userName,
                          style: AppStyle.bold20White,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '12',
                          style: AppStyle.bold36White,
                        ),
                        SizedBox(height: height * 0.008),
                        Text(
                          'Wish List',
                          style: AppStyle.bold24White,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '10',
                          style: AppStyle.bold36White,
                        ),
                        SizedBox(height: height * 0.008),
                        Text(
                          'History',
                          style: AppStyle.bold24White,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.032),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () async {
                            final updatedData = await Navigator.push<Map<String, dynamic>>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateProfileScreen(
                                  currentName: userName,
                                  currentPhone: userPhone,
                                  currentAvatar: userAvatar,
                                ),
                              ),
                            );

                            if (updatedData != null) {
                              setState(() {
                                userName = updatedData['name'];
                                userPhone = updatedData['phone'];
                                userAvatar = updatedData['avatar'];
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.yellowColor,
                            foregroundColor: AppColors.blackColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              'Edit Profile',
                              style: AppStyle.regular20Black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.012),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            //todo: exit the app
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redColor,
                            foregroundColor: AppColors.whiteColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Exit',
                                  style: AppStyle.regular20White,
                                ),
                              ),
                              SizedBox(width: width * 0.008),
                              Icon(
                                Icons.exit_to_app,
                                size: 20,
                                color: AppColors.whiteColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.032),
              TabBar(
                indicatorColor: AppColors.yellowColor,
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: AppColors.whiteColor,
                unselectedLabelColor: AppColors.whiteColor,
                labelStyle: AppStyle.regular20White,
                tabs: [
                  Tab(
                    icon: Icon(Icons.format_list_bulleted, size: 35, color: AppColors.yellowColor),
                    text: 'Watch List',
                  ),
                  Tab(
                    icon: Icon(Icons.folder, size: 35, color: AppColors.yellowColor),
                    text: 'History',
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  color: AppColors.blackColor,
                  child: TabBarView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("/Users/shawky/Desktop/greduation_movies_fluter/assets/images/iconProfile.png"),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("/Users/shawky/Desktop/greduation_movies_fluter/assets/images/iconProfile.png"),
                          ],
                      ),
                     ],
                  ),
                  ),
           ),
            ],
          ),
        ),
      ),
     );
  }
  
}