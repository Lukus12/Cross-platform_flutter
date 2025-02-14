import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:kross/app/features/features.dart';
import 'package:kross/data/dio/dio.dart';
import 'package:kross/domain/domain.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../app/features/favorites/bloc/favorites_bloc.dart';
import '../domain/service/user/user_data_service_interface.dart';

final Dio dio = Dio();
final getIt = GetIt.instance;
final talker = TalkerFlutter.init();

Future<void> setupLocator() async {
  getIt.registerSingleton(talker); // Регистрация Talker
  setUpDio(); // Настройка Dio

  getIt.registerSingleton<Dio>(dio); // Регистрация Dio в GetIt

  // Регистрация FactsAboutSpaceRepository с использованием зарегистрированного Dio
  getIt.registerSingleton<FactsAboutSpaceRepository>(FactsAboutSpaceRepository(dio: getIt<Dio>()));
  // Регистрация InsideFactsAboutSpaceRepository с использованием зарегистрированного Dio
  getIt.registerSingleton<InsideFactsAboutSpaceRepository>(InsideFactsAboutSpaceRepository(dio: getIt<Dio>()));

  // Регистрация HomeBloc с использованием зарегистрированного FactsAboutSpaceRepository
  getIt.registerSingleton<HomeBloc>(HomeBloc(getIt<FactsAboutSpaceRepository>()));
  // Регистрация HomeBloc с использованием зарегистрированного InsideFactsAboutSpaceRepository
  getIt.registerSingleton<InsideTheHomeBloc>(InsideTheHomeBloc(getIt<InsideFactsAboutSpaceRepository>()));

  getIt.registerSingleton<AuthRepository>(AuthRepository());

  getIt.registerSingleton<UserDataService>(UserDataService());

  getIt.registerSingleton<FavoritesRepository>(FavoritesRepository(dio: Dio()));

  getIt.registerSingleton<FavoritesBloc>(FavoritesBloc(getIt<FavoritesRepository>()));
}
