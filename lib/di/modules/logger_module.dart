import 'package:injectable/injectable.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

@module
abstract class LoggerModule {
  @lazySingleton
  Talker getLogger() {
    final talker = TalkerFlutter.init();
    return talker;
  }

  @lazySingleton
  TalkerDioLogger getTalkerDioLogger(Talker talker) {
    return TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseRedirects: true,
        printRequestExtra: true,
        printResponseTime: true,
      ),
    );
  }
}
