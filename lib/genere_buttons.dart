import 'package:flutter/material.dart';

class GenreButton extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const GenreButton({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(name),
        selected: isSelected,
        onSelected: (_) {
          onTap();
        },
      ),
    );
  }
}