import 'package:flutter/material.dart';
import 'package:flutter_soft_wars/resources/themes/app_colors.dart';
import 'package:flutter_soft_wars/resources/themes/app_text_style.dart';

class CustomRadioWidget extends StatelessWidget {
  const CustomRadioWidget({super.key, required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(color: AppColors.primaryVariant, shape: BoxShape.circle),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Text(label, style: AppTextStyle.medium18.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }
}
