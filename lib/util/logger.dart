import 'package:logger/logger.dart';

class LoggerUtil {
  static Logger _logger = Logger();

  LoggerUtil._internal();

  static Logger get logger => _logger;
  static set level(Level level) => Logger.level = level;
}
