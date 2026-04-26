import 'package:dio/dio.dart';
import 'package:flutter_soft_wars/core/environments/app_environment.dart';
import 'package:flutter_soft_wars/data/datasources/remote/client/rest_client.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';

@module
abstract class RestClientModule {
  @lazySingleton
  Dio getDio(AppEnvironment environment, TalkerDioLogger talkerDioLogger) {
    final dio = Dio()..options = BaseOptions(baseUrl: environment.tasksBaseUrl);

    dio.interceptors.addAll([talkerDioLogger]);

    return dio;
  }

  @lazySingleton
  RestClient getRestClient(Dio dio) => RestClient(dio);
}
