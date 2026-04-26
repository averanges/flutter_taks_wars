import 'package:flutter/material.dart';
import 'package:flutter_soft_wars/resources/themes/app_colors.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({required this.body, super.key, this.appBar, this.floatingActionButton});

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.background,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
