import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.title,
    required this.textStyle,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.side,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.width,
  });

  final String title;
  final TextStyle textStyle;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderSide? side;
  final EdgeInsetsGeometry? padding;
  final BorderRadius borderRadius;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          side: side,
          padding: padding,
        ),
        child: Text(title, style: textStyle, textAlign: TextAlign.center),
      ),
    );
  }
}
