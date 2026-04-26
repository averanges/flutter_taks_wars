import 'package:flutter_soft_wars/core/environments/app_environment.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppEnvironment)
@dev
class DevelopmentEnvironment implements AppEnvironment {
  @override
  String tasksBaseUrl = 'https://to-do.softwars.com.ua';
}
