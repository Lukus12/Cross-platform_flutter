import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kross/app/features/home/bloc/home_bloc.dart';
import 'package:kross/di/di.dart';
import 'package:kross/domain/repository/facts_about_space/facts_about_space_repository.dart';
import 'package:kross/kross.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  FlutterError.onError = (details) => talker.handle(
    details.exception,
    details.stack,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(getIt<KrossRepository>()),
        ),
        // Другие блоки при необходимости
      ],
      child: MyApp(),
    ),
  );
}


