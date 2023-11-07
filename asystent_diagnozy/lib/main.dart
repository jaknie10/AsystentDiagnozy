import 'package:flutter/material.dart';

import 'home.dart';
import 'profile.dart';
import 'settings.dart';

void main() => runApp(const MyApp());

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
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _page = 'home';

  @override
  Widget build(BuildContext context) {
    changeState(state) {
      setState(() {
        _page = state;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        toolbarHeight: 80,
        leading: Container(
            color: Colors.white,
            width: 80.0,
            child: IconButton(
              style: IconButton.styleFrom(
                  elevation: 0,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  )),
              onPressed: () {
                setState(() {
                  if (_page != 'home') _page = 'home';
                });
              },
              icon: ImageIcon(
                const AssetImage('assets/cardiologyLogo.png'),
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
            )),
        leadingWidth: 80,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 300,
            height: 45,
            child: SearchBar(),
          ),
        ),
        actions: [
          Container(
            width: 250,
            height: 80,
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: const Align(
                alignment: Alignment.centerLeft,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.people,
                        size: 30,
                        color: Colors.black,
                      ),
                      Text("Jan Kowalski",
                          style: TextStyle(fontSize: 20, color: Colors.black))
                    ])),
          )
        ], // default is 56
      ),
      body: Row(
        children: <Widget>[
          Container(
            width: 80,
            color: Colors.white,
            child: SafeArea(
                child: Column(
              children: [
                Container(
                    width: 100.0,
                    height: 80.0,
                    color: Colors.white,
                    child: IconButton(
                      style: IconButton.styleFrom(
                          elevation: 0,
                          hoverColor: Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          )),
                      onPressed: () {
                        setState(() {
                          if (_page != 'home') {
                            _page = 'home';
                            debugPrint(_page);
                          }
                        });
                      },
                      icon: _page == 'home'
                          ? const ImageIcon(
                              AssetImage('assets/home_focused.png'),
                              size: 30,
                              color: Color.fromRGBO(22, 20, 35, 60),
                            )
                          : const ImageIcon(
                              AssetImage('assets/home.png'),
                              size: 30,
                              color: Color.fromRGBO(22, 20, 35, 60),
                            ),
                    )),
                Container(
                  width: 100.0,
                  height: 80.0,
                  color: Colors.white,
                  child: IconButton(
                    style: IconButton.styleFrom(
                        elevation: 0,
                        hoverColor: Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        )),
                    onPressed: () {
                      setState(() {
                        if (_page != 'profile') {
                          _page = 'profile';
                          debugPrint(_page);
                        }
                      });
                    },
                    icon: _page == 'profile'
                        ? const ImageIcon(
                            AssetImage('assets/profile_focused.png'),
                            size: 30,
                            color: Color.fromRGBO(22, 20, 35, 60),
                          )
                        : const ImageIcon(
                            AssetImage('assets/profile.png'),
                            size: 30,
                            color: Color.fromRGBO(22, 20, 35, 60),
                          ),
                  ),
                ),
                Container(
                  width: 100.0,
                  height: 80.0,
                  color: Colors.white,
                  child: IconButton(
                    style: IconButton.styleFrom(
                        elevation: 0,
                        hoverColor: Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        )),
                    onPressed: () {
                      setState(() {
                        if (_page != 'settings') {
                          _page = 'settings';
                          debugPrint(_page);
                        }
                      });
                    },
                    icon: _page == 'settings'
                        ? const ImageIcon(
                            AssetImage('assets/settings_focused.png'),
                            size: 30,
                            color: Color.fromRGBO(22, 20, 35, 60),
                          )
                        : const ImageIcon(
                            AssetImage('assets/settings.png'),
                            size: 30,
                            color: Color.fromRGBO(175, 172, 195, 0.769),
                          ),
                  ),
                ),
              ],
            )),
          ),
          if (_page == 'settings')
            const Settings()
          else if (_page == 'home')
            const HomePage()
          else if (_page == 'profile')
            const Profile(),
        ],
      ),
    );
  }
}
