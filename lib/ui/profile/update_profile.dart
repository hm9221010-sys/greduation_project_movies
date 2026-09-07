import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/ui/profile/avatar_bottom_sheet.dart';
import 'package:greduation_movies_fluter/utils/app_Style.dart';
import 'package:greduation_movies_fluter/utils/app_color.dart';
import 'package:greduation_movies_fluter/utils/app_size.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentPhone;
  final String currentAvatar;

  const UpdateProfileScreen({
    Key? key,
    this.currentName = 'John Safwat',
    this.currentPhone = '01200000000',
    this.currentAvatar = 'assets/images/avatar8.png',
  }) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => UpdateProfileScreenState();
}

class UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late String selectedAvatar;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    phoneController = TextEditingController(text: widget.currentPhone);
    selectedAvatar = widget.currentAvatar;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.yellowColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pick Avatar ',
          style: AppStyle.black14Yellow,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.symmetric(horizontal: width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: height * 0.03),
            Center(
              child: GestureDetector(
                onTap: () async {
                  final result = await showModalBottomSheet<String>(
                    backgroundColor: AppColors.transparentColor,
                    context: context,
                    builder: (context) {
                      return UpdateAvatar(selectedAvatar: selectedAvatar);
                    },
                  );
                  if (result != null) {
                    setState(() {
                      selectedAvatar = result;
                    });
                  }
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(selectedAvatar),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            Container(
              decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: AppColors.whiteColor),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Container(
              decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                style: AppStyle.regular20White,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone, color: AppColors.whiteColor),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            SizedBox(height: height * 0.025),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  //todo: reset password
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Reset Password',
                  style: AppStyle.regular20White,
                ),
              ),
            ),
            SizedBox(height: height * 0.25),
            ElevatedButton(
              onPressed: () {
                //todo: delete account
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,
                foregroundColor: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              ),
              child: Text(
                'Delete Account',
                style: AppStyle.regular20White,
              ),
            ),
            SizedBox(height: height * 0.02),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'name': nameController.text,
                  'phone': phoneController.text,
                  'avatar': selectedAvatar,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.yellowColor,
                foregroundColor: AppColors.blackColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              ),
              child: Text(
                'Update Data',
                style: AppStyle.regular20Black,
              ),
            ),
            SizedBox(height: height * 0.02),
               ],
                 ),
      ),
    );

  }
}