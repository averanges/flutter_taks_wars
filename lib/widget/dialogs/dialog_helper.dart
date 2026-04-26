import 'package:flutter/material.dart';
import 'package:flutter_soft_wars/resources/themes/app_colors.dart';
import 'package:flutter_soft_wars/resources/themes/app_text_style.dart';
import 'package:go_router/go_router.dart';

class DialogHelper {
  static Future<void> showErrorDialog(BuildContext context, {required String message}) {
    return _showDialog(context: context, message: message, icon: Icons.close, colorIcon: AppColors.accentRed);
  }

  static Future<void> _showDialog({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color colorIcon,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          icon: Icon(icon, size: 28, color: colorIcon),
          content: Text(
            message,
            style: AppTextStyle.medium18.copyWith(color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text('OK', style: AppTextStyle.medium18.copyWith(color: AppColors.primaryVariant)),
            ),
          ],
        );
      },
    );
  }
}
