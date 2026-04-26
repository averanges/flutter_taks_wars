import 'package:flutter/material.dart';
import 'package:flutter_soft_wars/presentation/navigation/routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: Routes.router, debugShowCheckedModeBanner: false);
  }
}
