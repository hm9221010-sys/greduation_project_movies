import 'package:flutter/material.dart';

class ProfileAvatarPicker extends StatelessWidget {
  final String avatar;
  final VoidCallback onTap;

  const ProfileAvatarPicker({
    super.key,
    required this.avatar,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage(
            avatar,
          ),
        ),
      ),
    );
  }
}