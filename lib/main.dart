import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kross/app/features/features.dart';
import 'package:kross/di/di.dart';
import 'package:kross/domain/domain.dart';
import 'package:kross/kross.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();
  FlutterError.onError = (details) => talker.handle(
    details.exception,
    details.stack,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(getIt<FactsAboutSpaceRepository>()),
        ),
        // Другие блоки при необходимости
        BlocProvider(
          create: (context) => InsideTheHomeBloc(getIt<InsideFactsAboutSpaceRepository>()), // Add this line
        ),
      ],
      child: MyApp(),
    ),
  );
}


