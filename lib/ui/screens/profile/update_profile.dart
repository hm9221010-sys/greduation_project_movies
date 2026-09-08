import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/l10n/app_localizations.dart';
import 'package:greduation_movies_fluter/ui/screens/profile/avatar_bottom_sheet.dart';
import 'package:greduation_movies_fluter/utils/app_Style.dart';
import 'package:greduation_movies_fluter/utils/app_color.dart';
import 'package:greduation_movies_fluter/utils/app_size.dart';

import '../../../firebase_utils.dart';
import '../../../utils/route_name.dart';
import '../login/CustomButton.dart';
import '../login/custom_text_field.dart';
import 'components/delete_account.dart';
import 'components/profile_avatar_picker.dart';
import 'components/reset_password_button.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentPhone;
  final String currentAvatar;

  const UpdateProfileScreen({
    super.key,
    this.currentName = '',
    this.currentPhone = '',
    this.currentAvatar = 'assets/images/avatars/avatar_1.png',
  });

  @override
  State<UpdateProfileScreen> createState() =>
      _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late String selectedAvatar;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.currentName,
    );

    phoneController = TextEditingController(
      text: widget.currentPhone,
    );

    selectedAvatar = widget.currentAvatar;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> updateProfile() async {
    final lang = AppLocalizations.of(context)!;

    try {
      setState(() {
        isLoading = true;
      });

      await FirebaseUtils.updateUserData(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        avatar: selectedAvatar,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            lang.profileUpdatedSuccessfully,
          ),
        ),
      );

      await Future.delayed(
        const Duration(
          milliseconds: 700,
        ),
      );

      if (!mounted) return;

      Navigator.pop(
        context,
        {
          'name': nameController.text.trim(),
          'phone': phoneController.text.trim(),
          'avatar': selectedAvatar,
        },
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            lang.failedToUpdateProfile,
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> pickAvatar() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.transparentColor,
      builder: (context) {
        return UpdateAvatar(
          selectedAvatar: selectedAvatar,
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedAvatar = result;
      });
    }
  }

  Future<void> resetPassword() async {
    final lang = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;

    if (user?.email == null) return;

    try {
      await FirebaseUtils.resetPassword(
        email: user!.email!,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            lang.resetPasswordEmailSent,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            lang.somethingWentWrong,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    final height = context.height;
    final width = context.width;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.yellowColor,
          ),
        ),
        title: Text(
          lang.pickAvatar,
          style: AppStyle.black14Yellow,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: height * 0.03,
            ),

            //todo Avatar
            ProfileAvatarPicker(
              avatar: selectedAvatar,
              onTap: pickAvatar,
            ),

            SizedBox(
              height: height * 0.03,
            ),

            //todo Name
            CustomTextField(
              hintText: lang.name,
              prefixIcon: Icons.person,
              controller: nameController,
            ),

            SizedBox(
              height: height * 0.02,
            ),

            //todo Phone
            CustomTextField(
              hintText: lang.phoneNumber,
              prefixIcon: Icons.phone,
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),

            SizedBox(
              height: height * 0.025,
            ),

            //todo Reset Password
            ResetPasswordButton(
              text: lang.resetPassword,
              onPressed: resetPassword,
            ),

            SizedBox(
              height: height * 0.25,
            ),

            //todo Delete Account
            CustomButton(
              text: lang.deleteAccount,
              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.whiteColor,
              onPressed: () async {
                final confirm =
                await showDeleteAccountDialog(context);

                if (!confirm) return;

                try {
                  await FirebaseUtils.deleteAccount();

                  if (!mounted) return;

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteName.loginRoute,
                        (route) => false,
                  );
                } on FirebaseAuthException catch (e) {
                  if (!mounted) return;

                  if (e.code == 'requires-recent-login') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          lang.loginAgainToDeleteAccount,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          lang.somethingWentWrong,
                        ),
                      ),
                    );
                  }
                }
              },
            ),

            SizedBox(
              height: height * 0.02,
            ),

            //todo Update Data
            CustomButton(
              text: lang.updateData,
              onPressed: isLoading
                  ? null
                  : updateProfile,
              child: isLoading
                  ? const SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  color: AppColors.blackColor,
                  strokeWidth: 3,
                ),
              )
                  : null,
            ),

            SizedBox(
              height: height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}