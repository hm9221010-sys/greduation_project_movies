import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/utils/app_color.dart';
import 'package:greduation_movies_fluter/utils/app_size.dart';

class UpdateAvatar extends StatefulWidget {
  final String selectedAvatar;

  const UpdateAvatar({Key? key, required this.selectedAvatar}) : super(key: key);

  @override
  State<UpdateAvatar> createState() => _UpdateAvatarState();
}

class _UpdateAvatarState extends State<UpdateAvatar> {
  final List<String> avatars = [
    '/Users/shawky/Desktop/greduation_movies_fluter/assets/images/avatar1.png',
    '/Users/shawky/Desktop/greduation_movies_fluter/assets/images/avatar2.png',
    '/Users/shawky/Desktop/greduation_movies_fluter/assets/images/avatar3.png',
    '/Users/shawky/Desktop/greduation_movies_fluter/assets/images/avatar4.png',
    '/Users/shawky/Desktop/greduation_movies_fluter/assets/images/avatar5.png',
    '/Users/shawky/Desktop/greduation_movies_fluter/assets/images/avatar6.png',
    '/Users/shawky/Desktop/greduation_movies_fluter/assets/images/avatar7.png',
    '/Users/shawky/Desktop/greduation_movies_fluter/assets/images/avatar8.png',
    '/Users/shawky/Desktop/greduation_movies_fluter/assets/images/avatar9.png',
  ];

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      decoration: BoxDecoration(
        color: AppColors.greyColor, // خلفية الـ Bottom Sheet
        borderRadius: const BorderRadius.vertical(
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
          final isSelected = avatars[index] == widget.selectedAvatar;

          return GestureDetector(
            onTap: () {
              Navigator.pop(context, avatars[index]);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                // تغيير لون الخلفية بالكامل للأصفر إذا كانت الصورة مختارة
                color: isSelected ? AppColors.yellowColor : AppColors.blackColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.yellowColor : AppColors.yellowColor.withOpacity(0.4),
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  avatars[index],
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