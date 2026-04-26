import 'package:flutter/material.dart';
import 'package:flutter_soft_wars/app.dart';
import 'package:flutter_soft_wars/di/injector.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoRouter.optionURLReflectsImperativeAPIs = true;

  await configureDependencies(Environment.dev);

  await initializeDateFormatting('uk');

  runApp(const AppWidget());
}
