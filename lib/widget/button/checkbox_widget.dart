import 'package:flutter/material.dart';
import 'package:flutter_soft_wars/resources/themes/app_colors.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({
    super.key,
    required this.isActive,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.onToggle,
  });

  final bool isActive;
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(5));

    return GestureDetector(
      onTap: onToggle,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: isActive ? activeBorderColor : inactiveBorderColor),
          color: isActive ? AppColors.disabled : Colors.transparent,
        ),
        child: isActive ? const Icon(Icons.check_outlined, size: 20, color: AppColors.secondaryVariant) : null,
      ),
    );
  }
}
