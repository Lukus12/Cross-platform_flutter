import 'package:flutter/material.dart';
import 'package:kross/di/di.dart';
import 'package:kross/kross.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  FlutterError.onError = (details) => talker.handle(
    details.exception,
    details.stack,
  );
  runApp(const MyApp());
}


