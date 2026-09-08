import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/utils/app_color.dart';
import 'package:greduation_movies_fluter/utils/app_size.dart';

class UpdateAvatar extends StatefulWidget {
  final String selectedAvatar;

  const UpdateAvatar({
    super.key,
    required this.selectedAvatar,
  });

  @override
  State<UpdateAvatar> createState() => _UpdateAvatarState();
}

class _UpdateAvatarState extends State<UpdateAvatar> {
  final List<String> avatars = [
    'assets/images/avatars/avatar_1.png',
    'assets/images/avatars/avatar_2.png',
    'assets/images/avatars/avatar_3.png',
    'assets/images/avatars/avatar_4.png',
    'assets/images/avatars/avatar_5.png',
    'assets/images/avatars/avatar_7.png',
    'assets/images/avatars/avatar_8.png',
    'assets/images/avatars/avatar_9.png',
  ];

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      decoration: const BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: avatars.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: width * 0.03,
          mainAxisSpacing: height * 0.015,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final avatar = avatars[index];

          final isSelected =
              avatar == widget.selectedAvatar;

          return GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
                avatar,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.yellowColor
                    : AppColors.blackColor.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.yellowColor
                      : AppColors.yellowColor.withValues(
                    alpha: 0.4,
                  ),
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  avatar,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}