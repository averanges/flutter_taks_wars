import 'package:flutter/material.dart';
import 'package:flutter_soft_wars/resources/themes/app_colors.dart';
import 'package:flutter_soft_wars/resources/themes/app_text_style.dart';
import 'package:flutter_soft_wars/widget/button/button_widget.dart';

class FilterButtonWidget extends StatelessWidget {
  const FilterButtonWidget({
    this.width = 109,
    required this.title,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });

  final double? width;
  final String title;
  final bool isSelected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      width: width,
      title: title,
      textStyle: AppTextStyle.medium18.copyWith(height: 1.18),
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      backgroundColor: isSelected ? AppColors.disabled : Colors.transparent,
      foregroundColor: isSelected ? AppColors.secondaryVariant : AppColors.disabled,
      padding: const EdgeInsets.symmetric(vertical: 16),
      side: BorderSide(color: isSelected ? AppColors.secondaryVariant : AppColors.disabled),
      onPressed: onPressed,
    );
  }
}
