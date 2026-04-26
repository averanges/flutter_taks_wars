import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_soft_wars/di/injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: r'$initGetIt', preferRelativeImports: true, asExtension: true)
Future<void> configureDependencies(String environment) => getIt.$initGetIt(environment: environment);

T inject<T extends Object>({String? instanceName, dynamic param1, dynamic param2}) =>
    getIt<T>(instanceName: instanceName, param1: param1, param2: param2);
