import 'package:ark_flutter/src/logger/hybrid_logger.dart';
import 'package:ark_flutter/src/logger/simple_utc_printer.dart';
import 'package:logger/logger.dart';

// Getter to access the logger instance
Logger get logger => AppLogger.instance;

class AppLogger {
  static late final Logger instance;
}

void buildLogger(bool isLogLevelTrace) {
  final logger = Logger(
      output: HybridOutput(),
      filter: ProductionFilter(),
      level: isLogLevelTrace ? Level.trace : Level.debug,
      printer: SimpleUTCPrinter(
          // Colorful log messages
          colors: false,
          // Should each log print contain a timestamp
          printTime: true));

  AppLogger.instance = logger;
}
