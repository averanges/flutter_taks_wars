import 'package:flutter/material.dart';
import 'package:flutter_soft_wars/resources/themes/app_colors.dart';
import 'package:flutter_soft_wars/resources/themes/app_text_style.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    this.validator,
    this.hintText,
    this.isMultiline = false,
    this.height,
    this.textStyle,
    this.hintStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.backgroundColor = AppColors.secondaryVariant,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;

  final String? hintText;

  /// false = normal (1 line)
  /// true  = multi-line (expands: true)
  final bool isMultiline;

  /// Container height
  final double? height;

  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  final EdgeInsets padding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height,
              padding: padding,
              decoration: BoxDecoration(
                color: backgroundColor,
                border: fieldState.hasError
                    ? const Border(bottom: BorderSide(color: AppColors.accentRed, width: 2))
                    : null,
              ),
              child: TextField(
                controller: controller,
                onChanged: fieldState.didChange,
                maxLines: isMultiline ? null : 1,
                expands: isMultiline,
                style:
                    textStyle ??
                    AppTextStyle.semibold24.copyWith(fontSize: isMultiline ? 16 : 24, color: AppColors.primary),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle:
                      hintStyle ??
                      AppTextStyle.semibold24.copyWith(fontSize: isMultiline ? 16 : 24, color: AppColors.secondary),
                  border: InputBorder.none,
                  isCollapsed: true,
                ),
              ),
            ),

            if (fieldState.hasError) const SizedBox(height: 4),

            if (fieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  fieldState.errorText!,
                  style: AppTextStyle.regular10.copyWith(fontSize: 12, color: AppColors.accentRed),
                ),
              ),
          ],
        );
      },
    );
  }
}
