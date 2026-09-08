import 'package:flutter/material.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_size.dart';

class AvatarPicker extends StatefulWidget {
  final List<String> avatars;
  final String selectedAvatar;
  final ValueChanged<String> onAvatarSelected;

  const AvatarPicker({
    super.key,
    required this.avatars,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    currentIndex = widget.avatars.indexOf(widget.selectedAvatar);

    if (currentIndex == -1) {
      currentIndex = 0;
    }

    pageController = PageController(
      initialPage: currentIndex,
      viewportFraction: 0.32,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.25,
      child: PageView.builder(
        controller: pageController,
        itemCount: widget.avatars.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });

          widget.onAvatarSelected(
            widget.avatars[index],
          );
        },
        itemBuilder: (context, index) {
          final bool isSelected = index == currentIndex;

          return Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: isSelected
                  ? context.width * 0.34
                  : context.width * 0.22,

              height: isSelected
                  ? context.width * 0.34
                  : context.width * 0.22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.yellowColor
                      : AppColors.transparentColor,
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  widget.avatars[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}