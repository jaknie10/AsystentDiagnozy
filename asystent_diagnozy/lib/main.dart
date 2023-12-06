import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'layout.dart';
import 'package:window_size/window_size.dart';
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Asystent diagnozy');
    setWindowMinSize(const Size(1466, 768));
    setWindowMaxSize(Size.infinite);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asystent Diagnozy',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            primary: const Color.fromRGBO(0, 99, 248, 1.0),
            secondary: const Color.fromRGBO(0, 99, 248, 0.1),
            background: const Color.fromRGBO(238, 238, 238, 1)),
        fontFamily: 'Montserrat',
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor:
              const MaterialStatePropertyAll(Color.fromRGBO(0, 99, 248, 1)),
          thumbVisibility: const MaterialStatePropertyAll(true),
          trackVisibility: const MaterialStatePropertyAll(true),
        ),
        // textTheme: const TextTheme(headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
      ),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [Locale('pl')],
      home: const Layout(),
    );
  }
}
