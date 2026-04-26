import 'package:flutter/material.dart';
import 'package:flutter_soft_wars/resources/themes/app_colors.dart';
import 'package:flutter_soft_wars/resources/themes/app_text_style.dart';
import 'package:flutter_soft_wars/widget/button/button_widget.dart';

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.textStyle,
    this.width = 343,
    this.backgroundColor = AppColors.primaryVariant,
    this.foregroundColor = Colors.black,
  });

  final double? width;
  final String title;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      width: width,
      title: title,
      textStyle: textStyle ?? AppTextStyle.semibold24.copyWith(height: 1.2),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: const EdgeInsets.symmetric(vertical: 18.5),
      onPressed: onPressed,
    );
  }
}
