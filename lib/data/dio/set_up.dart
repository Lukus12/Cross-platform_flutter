import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:kross/di/di.dart';
void setUpDio() {
  dio.options.baseUrl = 'https://api.nasa.gov/planetary/'; // общая часть адресов запросов
  dio.options.queryParameters.addAll({
    'api_key': 'WrpLGddbOXMfsuW3fY3VefcfxVgsqZXgjOKbor1J', // сюда нужно будет подставить ключ/токен, выданный при регистрации
  });
  dio.options.connectTimeout = const Duration(minutes: 1);
  dio.options.receiveTimeout = const Duration(minutes: 1);
  dio.interceptors.addAll([
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
      ),
    ),
  ]);
}

