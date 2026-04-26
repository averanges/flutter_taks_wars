import 'package:flutter/material.dart';
import 'package:flutter_soft_wars/presentation/navigation/app_router.dart';
import 'package:flutter_soft_wars/presentation/pages/not_found/not_found_page.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final GoRouter router = GoRouter(
    initialLocation: AppRouter.initial,
    routes: AppRouter.routes,
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  static void pop(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.push(AppRouter.tasks);
    }
  }
}
