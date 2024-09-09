import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:kross/app/features/home/bloc/home_bloc.dart';
import 'package:kross/data/dio/dio.dart';
import 'package:kross/domain/domain.dart';
import 'package:talker_flutter/talker_flutter.dart';

final Dio dio = Dio();
final getIt = GetIt.instance;
final talker = TalkerFlutter.init();

Future<void> setupLocator() async {
  getIt.registerSingleton(talker); // Регистрация Talker
  setUpDio(); // Настройка Dio

  getIt.registerSingleton<Dio>(dio); // Регистрация Dio в GetIt

  // Регистрация KrossRepository с использованием зарегистрированного Dio
  getIt.registerSingleton<KrossRepository>(KrossRepository(dio: getIt<Dio>()));

  // Регистрация HomeBloc с использованием зарегистрированного KrossRepository
  getIt.registerSingleton<HomeBloc>(HomeBloc(getIt<KrossRepository>()));
}
