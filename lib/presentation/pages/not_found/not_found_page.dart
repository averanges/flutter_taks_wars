import 'package:flutter/material.dart';
import 'package:flutter_soft_wars/resources/themes/app_colors.dart';
import 'package:flutter_soft_wars/widget/scaffold_widget.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldWidget(
      body: Center(child: CircularProgressIndicator(color: AppColors.accentRed)),
    );
  }
}
