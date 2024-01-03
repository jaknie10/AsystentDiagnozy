import 'package:asystent_diagnozy/pages/login/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database/database_service.dart';
import 'layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double widgetOpacity = 0.0;
  final SQLiteHelper helper = SQLiteHelper();

  @override
  void initState() {
    super.initState();
    helper.initWinDB();

    Future.delayed(const Duration(milliseconds: 300), () {
      widgetOpacity = 1;
      setState(() {});
    });
    Future.delayed(const Duration(seconds: 3), () {
      initiateApp();
    });
  }

  initiateApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('REMEMBER_USER')) {
      prefs.setBool('REMEMBER_USER', false);
    }
    if (prefs.containsKey('LOGGED_USER') && prefs.getBool('REMEMBER_USER')!) {
      var loggedUser = await helper.getUserById(prefs.getInt("LOGGED_USER")!);
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Layout(user: loggedUser),
        ),
      );
    } else {
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginOrRegister(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          decoration:
              const BoxDecoration(color: Color.fromRGBO(238, 238, 238, 1)),
          child: AnimatedOpacity(
            duration: const Duration(seconds: 2),
            opacity: widgetOpacity,
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/logo_new.png'),
            ),
          )),
    );
  }
}
