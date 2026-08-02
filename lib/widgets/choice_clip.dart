import 'package:flutter/material.dart';

class CustomChoiceChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final double? width;
  final double height;
  final bool isDark;

  const CustomChoiceChip({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.width,
    this.height = 50,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final unselectedTextColor = isDark ? Colors.white70 : Colors.black54;
    final unselectedBorderColor = isDark ? Colors.white24 : Colors.grey.shade300;

    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * .4,
      height: height,
      child: ChoiceChip(
        showCheckmark: false,
        label: SizedBox(
          width: double.infinity,
          height: 100,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? const Color(0xFF6C63FF) : unselectedTextColor,
            ),
          ),
        ),
        selected: isSelected,
        selectedColor: const Color(0xFF6C63FF).withOpacity(.12),
        backgroundColor: isDark ? Colors.grey.shade800 : Colors.white,
        side: BorderSide(
          color: isSelected ? const Color(0xFF6C63FF) : unselectedBorderColor,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onSelected: (_) => onTap(),
      ),
    );
  }
}
